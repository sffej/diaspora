#original from https://github.com/jopper/diaspora
#modified by David Morley
require 'time'

#module ModifiedHelper
  def last_modified
    git_last='git log -1 --pretty=format:"%cd"'
    filepath = Rails.root.join('tmp', '.last_pull')
    time_min = 60
#    @header_name = "X-Git-Update"
    if File.writable?(filepath)
      begin
        mtime = File.mtime(filepath)
        last = IO.readlines(filepath).at(0)
      rescue Exception => e
        Rails.logger.info("Failed to read git status #{filepath}: #{e}")
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
#      headers[@header_name] = "#{last}"
    end
#end

#   Copyright (c) 2010, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.


git_cmd = `git log -1 --format="%H %ci"`
if git_cmd =~ /^([\d\w]+?)\s(.+)$/
  GIT_REVISION = $1
  GIT_UPDATE = $2.strip
else
  GIT_REVISION = nil
  GIT_UPDATE = nil
end
