module Morley
	module Shorten
	def self.short(url)
require 'net/http'
require 'uri'
require 'rubygems'
	#do
        apikey = AppConfig[:yourlsapi]
        new = Net::HTTP.get(URI.parse("http://boun.cc/yourls-api.php?action=shorturl&url=#{url}&signature=#{apikey}&format=simple"))
	#return new
	return (new)
#puts new
	end
	end
end
