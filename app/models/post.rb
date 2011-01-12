#   Copyright (c) 2010, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

class Post
  require File.join(Rails.root, 'lib/encryptable')
  require File.join(Rails.root, 'lib/diaspora/web_socket')
  include MongoMapper::Document
  include ApplicationHelper
  include ROXML
  include Diaspora::Webhooks

  xml_reader :_id
  xml_reader :diaspora_handle
  xml_reader :public
  xml_reader :created_at


  key :public, Boolean, :default => false

  key :diaspora_handle, String
  key :user_refs, Integer, :default => 0
  key :pending, Boolean, :default => false
  key :aspect_ids, Array, :typecast => 'ObjectId'

  many :comments, :class_name => 'Comment', :foreign_key => :post_id, :order => 'created_at ASC'
  many :aspects, :in => :aspect_ids, :class_name => 'Aspect'
  belongs_to :person, :class_name => 'Person'

  timestamps!

  cattr_reader :per_page
  @@per_page = 10

  before_destroy :propogate_retraction
  after_destroy :destroy_comments

  attr_accessible :user_refs
  
  def self.instantiate params
    new_post = self.new params.to_hash
    new_post.person = params[:person]
    new_post.aspect_ids = params[:aspect_ids]
    new_post.public = params[:public]
    new_post.pending = params[:pending]
    new_post.diaspora_handle = new_post.person.diaspora_handle
    new_post
  end

  def as_json(opts={})
    {
      :post => {
        :id     => self.id,
        :person => self.person.as_json,
      }
    }
  end

  def mutable?
    false
  end

  def subscribers(user)
    user.people_in_aspects(user.aspects_with_post(self.id))
  end

  def receive(postzord)
    xml_author = object.diaspora_handle
    if (postzord.salmon_author.diaspora_handle != xml_author)
      Rails.logger.info("event=receive status=abort reason='author in xml does not match retrieved person' payload_type=#{object.class} recipient=#{self.diaspora_handle} sender=#{salmon_author.diaspora_handle}")
      return nil
    end

    if postzord.user.contact_for(postzord.salmon_author)
      self.person = postzord.salmon_author
      #do post receive
    end

  end

  protected
  def destroy_comments
    comments.each{|c| c.destroy}
  end

  def propogate_retraction
    self.person.owner.retract(self)
  end
end

