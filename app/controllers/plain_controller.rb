#   Copyright (c) 2011, David Morley.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.
class PlainController < ApplicationController
  before_filter :authenticate_user!, :except => [:public, :shortenshow]
  respond_to :html
  layout nil
    require File.join(Rails.root, 'lib/shorten')

  def shorten
    @link = Morley::Shorten::short(params[:url])
    render :layout => false
  end

  def shortenshow
    buffer = Morley::Stats::stats(params[:url])
    result = JSON.parse(buffer)
      if result['link']
        @stats = result['link']['clicks']
        @longurl = result['link']['url']
      elsif result['longUrl']
        @stats = result['analytics']['allTime']['shortUrlClicks']
        @longurl = result['longUrl']
      elsif result['long-url']
        @stats = 'Stats only on dia.so and goo.gl URLs, Try it!'
        @longurl = result['long-url']
      else
        @stats = 'Error'
        @longurl = 'Error: Nothing found, must not be shortened'
      end
    render :layout => false
  end

end

