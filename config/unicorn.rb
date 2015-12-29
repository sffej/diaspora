require_relative "load_config"

port = ENV["PORT"]
port = port && !port.empty? ? port.to_i : nil

worker_processes 12

## Load the app before spawning workers
preload_app true

# How long to wait before killing an unresponsive worker
timeout 390

preload_app true
@sidekiq_pid = nil

pid '/home/david/diaspora/tmp/pids/unicorn.pid'
#listen '/home/david/diaspora/tmp/sockets/diaspora.sock', :backlog => 2048
listen "127.0.0.1:3000"

#stderr_path AppConfig.server.stderr_log.get if AppConfig.server.stderr_log.present?
#stdout_path AppConfig.server.stdout_log.get if AppConfig.server.stdout_log.present?

stderr_path "/home/david/diaspora/log/unicorn-stderr.log"
stdout_path "/home/david/diaspora/log/unicorn-stdout.log"

before_fork do |server, worker|
  # If using preload_app, enable this line
  ActiveRecord::Base.connection.disconnect!

  # disconnect redis if in use
  unless AppConfig.environment.single_process_mode?
    Sidekiq.redis {|redis| redis.client.disconnect }
  end

  if AppConfig.server.embed_sidekiq_worker?
    @sidekiq_pid ||= spawn('bin/bundle exec sidekiq')
  end

  old_pid = '/home/david/diaspora/tmp/pids/diaspora.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |_server, _worker|
  Logging.reopen # reopen logfiles to obtain a new file descriptor

  ActiveRecord::Base.establish_connection # preloading app in master, so reconnect to DB

  # We don't generate uuids in the frontend, but let's be on the safe side
  UUID.generator.next_sequence
end
