#   Copyright (c) 2010, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

class PostsController < ApplicationController
  skip_before_filter :count_requests
  skip_before_filter :set_invites
  skip_before_filter :set_locale
  skip_before_filter :which_action_and_user
  skip_before_filter :set_grammatical_gender

  def index
    @posts = StatusMessage.joins(:author).where(Person.arel_table[:owner_id].not_eq(nil)).where(:public => true, :pending => false
             ).includes(:comments, :photos
             ).paginate(:page => params[:page], :per_page => 15, :order => 'created_at DESC')

    @fakes = PostsFake.new(@posts)
    @commenting_disabled = true
    @pod_url = AppConfig[:pod_uri].host
  end

  def show
    @post = Post.where(:id => params[:id], :public => true).includes(:author, :comments => :author).first

    if @post
      @landing_page = true
      @person = @post.author
      if @person.owner_id
        I18n.locale = @person.owner.language
        render "posts/#{@post.class.to_s.underscore}", :layout => true
      else
        flash[:error] = "that post does not exsist!"
        redirect_to root_url
      end
    else
      flash[:error] = "that post does not exsist!"
      redirect_to root_url
    end
  end
end
