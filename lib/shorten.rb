module Morley
	module Shorten
	def self.short(url)
require 'net/http'
require 'uri'
require 'rubygems'
	#do
        new = Net::HTTP.get(URI.parse("http://boun.cc/yourls-api.php?action=shorturl&url=#{url}&signature=b6be212a4e&format=simple"))
	#return new
	return (new)
#puts new
	end
	end
end
