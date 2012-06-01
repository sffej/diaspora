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
           if !url or url =~ (Regexp.new '/test.host/')
             return (url)
           else
             new = Net::HTTP.get(URI.parse("http://dia.so/diaspora-api.php?action=shorturl&url=#{url}&format=simple&signature=d388503621"))
             return (new)
	   end 
         end
	end
        module Stats
         def self.stats(url)
           if url =~ (Regexp.new "/dia.so/")
             jsonstats = Net::HTTP.get(URI.parse("http://dia.so/diaspora-api.php?action=url-stats&shorturl=#{url}&format=json&signature=d388503621"))
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
