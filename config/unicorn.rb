require File.expand_path('../load_config', __FILE__)

worker_processes 3

## Load the app before spawning workers
preload_app true

# How long to wait before killing an unresponsive worker
timeout 60

pid '/home/dmm/diaspora/tmp/pids/unicorn.pid'
listen '/home/dmm/run/diaspora.sock'
@resque_pid = nil
@sidekiq_pid = nil



stderr_path AppConfig.server.stderr_log.get if AppConfig.server.stderr_log.present?
stdout_path AppConfig.server.stdout_log.get if AppConfig.server.stdout_log.present?

before_fork do |server, worker|
  # If using preload_app, enable this line
  ActiveRecord::Base.connection.disconnect!

  # disconnect redis if in use
  unless AppConfig.single_process_mode?
    Sidekiq.redis {|redis| redis.client.disconnect }
  end
  
  if AppConfig.server.embed_sidekiq_worker?
    @sidekiq_pid ||= spawn('bundle exec sidekiq')
  end

  old_pid = '/var/run/diaspora/diaspora.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end


after_fork do |server, worker|
  # If using preload_app, enable this line
  ActiveRecord::Base.establish_connection
end
