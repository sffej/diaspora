God::Contacts::Email.defaults do |d|
  d.from_email = 'god@diasp.org'
  d.to_email = 'pod-god-alerts@usr.io'
  d.from_name = 'God'
  d.delivery_method = :sendmail
end

God.contact(:email) do |c|
  c.name = 'david'
  c.group = 'developers'
end

rails_env   = ENV['RAILS_ENV']  || "production"
rails_root  = ENV['RAILS_ROOT'] || "/home/david/diaspora"

God.watch do |w|
  w.name     = "camo"
  w.pid_file = "#{rails_root}/tmp/pids/camo.pid"
  w.interval = 100.seconds

  w.env      = {
    "NODE_TLS_REJECT_UNAUTHORIZED" => 0,
    "CAMO_LENGTH_LIMIT" => 20485760,
    "CAMO_HEADER_VIA" => 'Camo Asset Proxy at diasp.org',
    "CAMO_HOSTNAME" => 'Diaspora Camo',
    "CAMO_TIMING_ALLOW_ORIGIN" => '*',
    "CAMO_SOCKET_TIMEOUT" => 20,
    "CAMO_LOGGING_ENABLED" => 'disable',
    "CAMO_MAX_REDIRECTS" => 6,
    "CAMO_KEEP_ALIVE" => 'false'
  }

  w.start       = "cd #{rails_root}/camo && exec /usr/bin/nodejs server.js >> #{rails_root}/log/camo.stdout.log 2>> #{rails_root}/log/camo.stderr.log & echo $! > #{rails_root}/tmp/pids/camo.pid" 
  w.stop_signal = "TERM"

  # retart if memory gets too high
  w.transition(:up, :restart) do |on|
    on.condition(:memory_usage) do |c|
      c.above  = 500.megabytes
      c.times  = 2
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
