God::Contacts::Email.defaults do |d|
  d.from_email = 'god@diasp.org'
  d.to_email = 'davidmorley@diasp.org'
  d.from_name = 'God'
  d.delivery_method = :sendmail
end
God.contact(:email) do |c|
  c.name = 'david'
  c.group = 'developers'
end
rails_env   = ENV['RAILS_ENV']  || "production"
rails_root  = ENV['RAILS_ROOT'] || "/home/dmm/diaspora"
num_resqueworkers = 5

num_resqueworkers.times do |num|
  God.watch do |w|
    w.dir      = "#{rails_root}"
    w.name     = "sidekiq-#{num}"
    w.group    = 'sidekiqs'
    w.interval = 290.seconds
    #w.env      = {"RAILS_ENV"=>rails_env}
    w.start    = "bundle exec sidekiq"
    w.log      = "#{rails_root}/log/god.log"
    #w.start_grace = 100.seconds

    #w.uid = 'dmm'
    #w.gid = 'dmm'

    # restart if memory gets too high
    w.transition(:up, :restart) do |on|
      on.condition(:memory_usage) do |c|
        c.above = 1150.megabytes
        c.times = 7
        c.notify = 'david'        
      end
    end

    # determine the state on startup
    w.transition(:init, { true => :up, false => :start }) do |on|
      on.condition(:process_running) do |c|
        c.running = true
      end
    end

    # determine when process has finished starting
    w.transition([:start, :restart], :up) do |on|
      on.condition(:process_running) do |c|
        c.running = true
        c.interval = 15.seconds
      end

      # failsafe
      on.condition(:tries) do |c|
        c.times = 5
        c.transition = :start
        c.interval = 15.seconds
      end
    end

    # start if process is not running
    w.transition(:up, :start) do |on|
      on.condition(:process_running) do |c|
        c.running = false
	c.notify = 'david'
      end
    end
  end
end


God.watch do |w|
  w.name = "unicorn"
  #w.group    = 'diaspora'
  w.interval = 200.seconds # default

  # unicorn needs to be run from the rails root
  w.start = "cd #{rails_root} && unicorn -c #{rails_root}/config/unicorn.rb -E #{rails_env} -D"

  # QUIT gracefully shuts down workers
  w.stop = "kill -QUIT `cat #{rails_root}/tmp/pids/unicorn.pid`"

  # USR2 causes the master to re-create itself and spawn a new worker pool
  w.restart = "kill -USR2 `cat #{rails_root}/tmp/pids/unicorn.pid`"

  w.start_grace = 1.seconds
  w.restart_grace = 1.seconds
  w.pid_file = "#{rails_root}/tmp/pids/unicorn.pid"

  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 15.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 300.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
    end

    restart.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
    end
  end

  # lifecycle
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end
