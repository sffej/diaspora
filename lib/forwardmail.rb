#   Copyright (c) 2010, David Morley.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

module Morley
	module Forwardmailon
		command = 0
		def self.forward(user,email,command)
		Rails.logger.info("event=emailforward status=start user=#{user}")
		##check existing system aliases for conflict or error
			begin
                        systemaliases = AppConfig[:system_aliases]
			file = File.new(systemaliases, "r")
				while (line = file.gets)
				sysalias = line.split(":")
					if sysalias[0] == user or user == 'root'
					return "ERROR: System reserved email sorry can not be added to forwarding rules"
                                        Rails.logger.info("event=emailforward status=error-systemalias user=#{user}")
					exit
					end
				end
			file.close
			rescue => err
			return "ERROR: Exception: #{err}"
			err
			exit
			end
		##create or update alias for postfix
		r = 0
		updated = 0
		require 'tempfile'
		require 'fileutils'
		## make sure you have cron making something out of etc/daliases and included in your main.cf with /etc/aliases
		path = AppConfig[:pod_aliases]
		temp_file = Tempfile.open('/tmp/fred')
		File.open(path, 'r') do |file|
		file.each_line do |line|
		exists = line.split(":")
			if exists[0] == user
                        Rails.logger.info("event=emailforward status=match user=#{user}")
				if command == 1
				temp_file.puts "#{user}:#{email}"
				r = 1
				updated = 1
				else command == 0
				temp_file.print ""
				r = 2
				updated = 1
				end
				else
				temp_file.puts line
				end
			end
			if updated == 0 && command == 1
			#else new line with forward
			r = 3
			temp_file.puts "#{user}:#{email}"
                        Rails.logger.info("event=emailforward status=addnewforward user=#{user}")
			end
		end
                Rails.logger.info("event=emailforward status=finished user=#{user}")
		FileUtils.mv(temp_file.path, path)
		temp_file.close
			if r == 1
			return "Success: Updated your existing forward"
			elsif r == 2
			return "Success: Removed your forward"
			elsif r == 3
			return "Success: Added your forward"
			else
			return "ERROR: Unknown Error"
			end
		end
	end
end

