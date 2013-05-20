#   Copyright (c) 2011, David Morley.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

module Morley
module Shorty
 def self.swap(message)
require 'net/http'
require 'uri'
require 'rubygems'
    message.gsub!(/( |^)(www\.[^\s]+\.[^\s])/, '\1http://\2')
    message.gsub!(/(<a target="\\?_blank" href=")?(https|http|ftp):\/\/\/([^\s]+)/) do |m|
      if !$1.nil?
        m
      else
        #do
        oldurl = CGI::escape("#{$2}://#{$3}")
        newurl = Net::HTTP.get(URI.parse("http://dia.so/diaspora-api.php?action=shorturl&url=#{oldurl}&format=simple&signature=0bcafe4b72"))
        res = %{#{newurl}}
        res.gsub!(/(\*|_)/) { |m| "\\#{$1}" }
        res
      end
    end
    return message
end
end
end

