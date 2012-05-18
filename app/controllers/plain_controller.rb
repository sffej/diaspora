#   Copyright (c) 2011, David Morley.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.
class PlainController < ApplicationController
  before_filter :authenticate_user!, :except => [:public, :shortenshow, :kiva]
  respond_to :html
  layout nil
    require File.join(Rails.root, 'lib/forwardmail')
    require File.join(Rails.root, 'lib/shorten')

  def forwardemail
    user = User.find_by_username(params[:username])
    render :layout => false
    return
  end

  def forwardemailon
     forward = Morley::Forwardmailon::forward(current_user.username,current_user.email,1)
     results = forward.split(":")
        if results[0] == "Success" 
          render :text => results[1], :status => 200 
        else
          render :text => results[1], :status => 200
	end
  end

  def forwardemailoff
     forward = Morley::Forwardmailon::forward(current_user.username,current_user.email,0)
     results = forward.split(":")
	if results[0] == "Success" 
          render :text => results[1], :status => 200
	else
          render :text => results[1], :status => 200
	end
  end

  def help
    render :layout => false
    return
  end

  def status
    render :layout => false
    return
  end

  def fb
    @user     = current_user.diaspora_handle
    render :layout => false
    return
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

   def kiva
#   render :layout => false
    require 'kiva'
    @newest = Kiva::Loan.load_newest
   end

   def git
    render :layout => false
    require 'git'
    g = Git.open('/root/diaspora')
    @commits = g.config('user.name')
   end


end

