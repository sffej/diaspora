#from https://github.com/jopper/diaspora/tree/master/app/helpers
#require 'ftools'
require 'time'

module ModifiedHelper
  def last_modified
    git_last='git log -1 --pretty=format:"%ar"'
    filepath = Rails.root.join('tmp', '.last_pull')
    time_min = 60

    if File.writable?(filepath)
      begin
        mtime = File.mtime(filepath)
        last = IO.readlines(filepath).at(0)
      rescue Exception => e
        Rails.logger.info("Failed to read git status #{filepath}: #{e}")
      end

      if last =~ /minutes/
        time_min = 60*5
      elsif last =~ /hours/
        time_min = 60*60
      else
        time_min = 60*60*24
      end
    end

    if (mtime.nil? || mtime < Time.now-time_min)
      last = `#{git_last}`
      begin
        f = File.open(filepath, 'w')
        f.puts(last)
        f.close
      rescue Exception => e
        Rails.logger.info("Failed to log git status #{filepath}: #{e}")
      end
    end

    last
  end
end

