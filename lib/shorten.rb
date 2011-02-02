module Morley
      require 'net/http'
      require 'uri'
      require 'rubygems'
	 module Shorten
	 def self.short(url)
         apikey = AppConfig[:yourlsapi]
         apidomain = AppConfig[:yourlsurl]
         if !url or url =~ 'test.host'
         return (url)
         else
         new = Net::HTTP.get(URI.parse("http://#{apidomain}/yourls-api.php?action=shorturl&url=#{url}&signature=#{apikey}&format=simple"))
         return (new)
	end 
        end
	end
         module Expand
         def self.long(url)
         apikey = AppConfig[:yourlsapi]
         apidomain = AppConfig[:yourlsurl]
         if url
          new = Net::HTTP.get(URI.parse("http://#{apidomain}/yourls-api.php?action=expand&shorturl=#{url}&signature=#{apikey}&format=simple"))
         end
         return (new)
         end
        end
         module Stats
         def self.stats(url)
         apikey = AppConfig[:yourlsapi]
         apidomain = AppConfig[:yourlsurl]
         if url
          new = Net::HTTP.get(URI.parse("http://#{apidomain}/yourls-api.php?action=url-stats&shorturl=#{url}&signature=#{apikey}&format=json"))
         end
         return (new)
         end
        end

end
