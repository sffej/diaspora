#   Copyright (c) 2010, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.
class PlainController < ApplicationController
before_filter :authenticate_user!, :except => [:public]
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

@longurl = Morley::Expand::long(params[:url])
buffer = Morley::Stats::stats(params[:url])
result = JSON.parse(buffer)
@stats = result['link']['clicks']
Rails.logger.info("json=#{buffer} clicks=#{result['link']['clicks']}")
  end


end

