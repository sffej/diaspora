#!/usr/bin/env ruby
 
# List of spam accounts
spam_accounts = %w(atiffanybuy@diasp.org)
 
# Delete comments even if spammer isn't a local user or spam isn't on a
# local users account
always_delete = true
 
# Keep empty (%w() or []) to retract spam comments from remote accounts
# for all local users
retract_for = %w()
 
###########################################################################
 
# Load diaspora environment
ENV['RAILS_ENV'] ||= "production"
require_relative 'config/environment'
 
local_spammers, remote_spammers = Person.where(diaspora_handle: spam_accounts).partition(&:local?)
 
# Retract all comments of local spammers and close their accounts
local_spammers.each do |spammer|
Comment.where(author_id: spammer.id).each do |comment|
spammer.owner.retract(comment)
end
spammer.owner.close_account!
end
 
# Retract all spam comments on posts of local users and delete the rest
Comment.where(author_id: remote_spammers.map(&:id)).each do |comment|
post_author = comment.parent.author
if post_author.local? && (retract_for.include?(post_author.owner.username) || retract_for.empty?)
post_author.owner.retract(comment)
elsif always_delete
comment.destroy
end
end

