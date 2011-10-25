God::Contacts::Email.defaults do |d|
  d.from_email = 'god@diasp.org'
  d.to_email = 'god@diasp.org'
  d.from_name = 'God'
  d.delivery_method = :sendmail
end
God.contact(:email) do |c|
  c.name = 'david'
  c.group = 'developers'
end
rails_env   = ENV['RAILS_ENV']  || "production"
rails_root  = ENV['RAILS_ROOT'] || "/root/diaspora"
num_workers = rails_env == 'production' ? 2 : 2

num_workers.times do |num|
  God.watch do |w|
    w.dir      = "#{rails_root}"
    w.name     = "resque-#{num}"
    w.group    = 'resque'
    w.interval = 90.seconds
    w.env      = {"QUEUE"=>"*", "RAILS_ENV"=>rails_env}
    w.start    = "bundle exec rake resque:work"
    w.log      = "#{rails_root}/log/god.log"

    w.uid = 'root'
    w.gid = 'root'

    # restart if memory gets too high
    w.transition(:up, :restart) do |on|
      on.condition(:memory_usage) do |c|
        c.above = 350.megabytes
        c.times = 2
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
        c.interval = 5.seconds
      end

      # failsafe
      on.condition(:tries) do |c|
        c.times = 5
        c.transition = :start
        c.interval = 5.seconds
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

