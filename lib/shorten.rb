module Morley
	module Shorten
	def self.short(url)
require 'net/http'
require 'uri'
require 'rubygems'
        apikey = AppConfig[:yourlsapi]
        if url
          new = Net::HTTP.get(URI.parse("http://boun.cc/yourls-api.php?action=shorturl&url=#{url}&signature=#{apikey}&format=simple"))
        end
	return (new)
	end
	end
end
