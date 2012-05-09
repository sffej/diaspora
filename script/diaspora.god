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
rails_root  = ENV['RAILS_ROOT'] || "/home/dmm/diaspora"
num_resqueworkers = 10


num_resqueworkers.times do |num|
  God.watch do |w|
    w.dir      = "#{rails_root}"
    w.name     = "resque-#{num}"
    w.group    = 'resque'
    w.interval = 190.seconds
    w.env      = {"QUEUE"=>"photos,receive_local,receive_salmon,receive,mail,socket_webfinger,delete_account,dispatch,http,http_service", "RAILS_ENV"=>rails_env}
    w.start    = "bundle exec rake resque:work"
    w.log      = "#{rails_root}/log/god.log"

    #w.uid = 'dmm'
    #w.gid = 'dmm'

    # restart if memory gets too high
    w.transition(:up, :restart) do |on|
      on.condition(:memory_usage) do |c|
        c.above = 250.megabytes
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


