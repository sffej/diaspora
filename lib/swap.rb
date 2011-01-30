module Morley
module Shorty
 def self.swap(message)
require 'net/http'
require 'uri'
require 'rubygems'
    message.gsub!(/( |^)(www\.[^\s]+\.[^\s])/, '\1http:///\2')
    message.gsub!(/(<a target="\\?_blank" href=")?(https|http|ftp):\/\/\/([^\s]+)/) do |m|
      if !$1.nil?
        m
      else
        #do
        apikey = AppConfig[:yourlsapi]
        oldurl = CGI::escape("#{$2}://#{$3}")
        if message
        newurl = Net::HTTP.get(URI.parse("http://boun.cc/yourls-api.php?action=shorturl&url=#{oldurl}&signature=#{apikey}&format=simple"))
        end
        res = %{#{newurl}}
        res.gsub!(/(\*|_)/) { |m| "\\#{$1}" }
        res
      end
    end
    return message
end
end
end

