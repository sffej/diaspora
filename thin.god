# == God config file
# http://god.rubyforge.org/
# Authors: Gump and michael@glauche.de
#
# Config file for god that configures watches for each instance of a thin server for
# each thin configuration file found in /etc/thin.
# In order to get it working on Ubuntu, I had to make a change to god as noted at
# the following blog:
# http://blog.alexgirard.com/ruby-one-line-to-save-god/
#
#require 'yaml'

#config_path = "/root/diaspora/config"

#Dir[config_path + "/thin.yml"].each do |file|
 # config = YAML.load_file(file)
  num_servers = 1

  (0...num_servers).each do |i|
    # UNIX socket cluster use number 0 to 2 (for 3 servers)
    # and tcp cluster use port number 3000 to 3002.
    number = 3005
    
    God.watch do |w|
      w.group = "thin"
      w.name = w.group + "-#{number}"
      w.env      = {"RAILS_ENV"=>"production"}      
      w.interval = 30.seconds
      
      w.uid = 'root'
      w.gid = 'root'
      
      w.start = "thin start -o #{number}"
      w.start_grace = 10.seconds
      
      w.stop = "thin stop -o #{number}"
      w.stop_grace = 10.seconds
      
      w.restart = "thin restart -o #{number}"

      pid_path = config["chdir"] + "/" + config["pid"]
      ext = File.extname(pid_path)

      w.pid_file = pid_path.gsub(/#{ext}$/, ".#{number}#{ext}")
      
      w.behavior(:clean_pid_file)

      w.start_if do |start|
        start.condition(:process_running) do |c|
          c.interval = 5.seconds
          c.running = false
        end
      end

      w.restart_if do |restart|
        restart.condition(:memory_usage) do |c|
          c.above = 150.megabytes
          c.times = [3,5] # 3 out of 5 intervals
        end

        restart.condition(:cpu_usage) do |c|
          c.above = 80.percent
          c.times = 5
        end
      end

      w.lifecycle do |on|
        on.condition(:flapping) do |c|
          c.to_state = [:start, :restart]
          c.times = 5
          c.within = 5.minutes
          c.transition = :unmonitored
          c.retry_in = 10.minutes
          c.retry_times = 5
          c.retry_within = 2.hours
        end
      end
    end
  end
#end
