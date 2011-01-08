module Morley
	module Shorten
	def self.short(url)
require 'net/http'
require 'uri'
require 'rubygems'
	#do
        new = Net::HTTP.get(URI.parse("http://boun.cc/yourls-api.php?action=shorturl&url=#{url}&signature=ef2748f487&format=simple"))
	#return new
	return (new)
#puts new
	end
	end
end
