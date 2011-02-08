#   Copyright (c) 2011, David Morley.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.
module Morley
      require 'net/http'
      require 'net/https'
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
        module Stats
         def self.stats(url)
         apikey = AppConfig[:yourlsapi]
         apidomain = AppConfig[:yourlsurl]
           if url =~ (Regexp.new "/boun.cc/")
             jsonstats = Net::HTTP.get(URI.parse("http://#{apidomain}/yourls-api.php?action=url-stats&shorturl=#{url}&signature=#{apikey}&format=json"))
           elsif url =~ (Regexp.new "/goo.gl/")
             uri = URI.parse("https://www.googleapis.com/urlshortener/v1/url?projection=FULL&shortUrl=#{url}")
             http = Net::HTTP.new(uri.host, uri.port)
             http.use_ssl = true
             http.verify_mode = OpenSSL::SSL::VERIFY_NONE
             request = Net::HTTP::Get.new(uri.request_uri)
             response = http.request(request)
             jsonstats = response.body
           elsif url
             jsonstats = Net::HTTP.get(URI.parse("http://api.longurl.org/v2/expand?format=json&user-agent=diasp.org&url=#{url}"))
           end
         return (jsonstats)
         end
        end
end
