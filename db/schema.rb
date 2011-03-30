# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110330175950) do

  create_table "aspect_memberships", :force => true do |t|
    t.integer  "aspect_id",  :null => false
    t.integer  "contact_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aspect_memberships", ["aspect_id", "contact_id"], :name => "index_aspect_memberships_on_aspect_id_and_contact_id", :unique => true
  add_index "aspect_memberships", ["aspect_id"], :name => "index_aspect_memberships_on_aspect_id"
  add_index "aspect_memberships", ["contact_id"], :name => "index_aspect_memberships_on_contact_id"

  create_table "aspect_visibilities", :force => true do |t|
    t.integer  "post_id",    :null => false
    t.integer  "aspect_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aspect_visibilities", ["aspect_id"], :name => "index_aspect_visibilities_on_aspect_id"
  add_index "aspect_visibilities", ["post_id", "aspect_id"], :name => "index_aspect_visibilities_on_post_id_and_aspect_id", :unique => true
  add_index "aspect_visibilities", ["post_id"], :name => "index_aspect_visibilities_on_post_id"

  create_table "aspects", :force => true do |t|
    t.string   "name",                                :null => false
    t.integer  "user_id",                             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mongo_id"
    t.string   "user_mongo_id"
    t.boolean  "contacts_visible", :default => true,  :null => false
    t.boolean  "open",             :default => false
  end

  add_index "aspects", ["mongo_id"], :name => "index_aspects_on_mongo_id"
  add_index "aspects", ["user_id", "contacts_visible"], :name => "index_aspects_on_user_id_and_contacts_visible"
  add_index "aspects", ["user_id"], :name => "index_aspects_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "text",                    :null => false
    t.integer  "post_id",                 :null => false
    t.integer  "author_id",               :null => false
    t.string   "guid",                    :null => false
    t.text     "author_signature"
    t.text     "parent_author_signature"
    t.text     "youtube_titles"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mongo_id"
  end

  add_index "comments", ["author_id"], :name => "index_comments_on_person_id"
  add_index "comments", ["guid"], :name => "index_comments_on_guid", :unique => true
  add_index "comments", ["mongo_id"], :name => "index_comments_on_mongo_id"
  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "contacts", :force => true do |t|
    t.integer  "user_id",                      :null => false
    t.integer  "person_id",                    :null => false
    t.boolean  "pending",    :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mongo_id"
  end

  add_index "contacts", ["mongo_id"], :name => "index_contacts_on_mongo_id"
  add_index "contacts", ["person_id", "pending"], :name => "index_contacts_on_person_id_and_pending"
  add_index "contacts", ["user_id", "pending"], :name => "index_contacts_on_user_id_and_pending"
  add_index "contacts", ["user_id", "person_id"], :name => "index_contacts_on_user_id_and_person_id", :unique => true

  create_table "conversation_visibilities", :force => true do |t|
    t.integer  "conversation_id",                :null => false
    t.integer  "person_id",                      :null => false
    t.integer  "unread",          :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversation_visibilities", ["conversation_id", "person_id"], :name => "index_conversation_visibilities_on_conversation_id_and_person_id", :unique => true
  add_index "conversation_visibilities", ["conversation_id"], :name => "index_conversation_visibilities_on_conversation_id"
  add_index "conversation_visibilities", ["person_id"], :name => "index_conversation_visibilities_on_person_id"

  create_table "conversations", :force => true do |t|
    t.string   "subject"
    t.string   "guid",       :null => false
    t.integer  "author_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.text     "message"
    t.integer  "sender_id",    :null => false
    t.integer  "recipient_id", :null => false
    t.integer  "aspect_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mongo_id"
  end

  add_index "invitations", ["aspect_id"], :name => "index_invitations_on_aspect_id"
  add_index "invitations", ["mongo_id"], :name => "index_invitations_on_mongo_id"
  add_index "invitations", ["recipient_id"], :name => "index_invitations_on_recipient_id"
  add_index "invitations", ["sender_id"], :name => "index_invitations_on_sender_id"

  create_table "likes", :force => true do |t|
    t.boolean  "positive",                :default => true
    t.integer  "post_id"
    t.integer  "author_id"
    t.string   "guid"
    t.text     "author_signature"
    t.text     "parent_author_signature"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["author_id"], :name => "likes_author_id_fk"
  add_index "likes", ["guid"], :name => "index_likes_on_guid", :unique => true
  add_index "likes", ["post_id"], :name => "index_likes_on_post_id"

  create_table "mentions", :force => true do |t|
    t.integer "post_id",   :null => false
    t.integer "person_id", :null => false
  end

  add_index "mentions", ["person_id", "post_id"], :name => "index_mentions_on_person_id_and_post_id", :unique => true
  add_index "mentions", ["person_id"], :name => "index_mentions_on_person_id"
  add_index "mentions", ["post_id"], :name => "index_mentions_on_post_id"

  create_table "messages", :force => true do |t|
    t.integer  "conversation_id",         :null => false
    t.integer  "author_id",               :null => false
    t.string   "guid",                    :null => false
    t.text     "text",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "author_signature"
    t.text     "parent_author_signature"
  end

  add_index "messages", ["author_id"], :name => "index_messages_on_author_id"

  create_table "mongo_notifications", :force => true do |t|
    t.string   "mongo_id"
    t.string   "target_type",        :limit => 127
    t.string   "target_mongo_id",    :limit => 127
    t.string   "recipient_mongo_id"
    t.string   "actor_mongo_id"
    t.string   "action"
    t.boolean  "unread",                            :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mongo_notifications", ["target_type", "target_mongo_id"], :name => "index_mongo_notifications_on_target_type_and_target_mongo_id"

  create_table "notification_actors", :force => true do |t|
    t.integer  "notification_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notification_actors", ["notification_id", "person_id"], :name => "index_notification_actors_on_notification_id_and_person_id", :unique => true
  add_index "notification_actors", ["notification_id"], :name => "index_notification_actors_on_notification_id"
  add_index "notification_actors", ["person_id"], :name => "index_notification_actors_on_person_id"

  create_table "notifications", :force => true do |t|
    t.string   "target_type"
    t.integer  "target_id"
    t.integer  "recipient_id",                   :null => false
    t.boolean  "unread",       :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "notifications", ["recipient_id"], :name => "index_notifications_on_recipient_id"
  add_index "notifications", ["target_id"], :name => "index_notifications_on_target_id"
  add_index "notifications", ["target_type", "target_id"], :name => "index_notifications_on_target_type_and_target_id"

  create_table "people", :force => true do |t|
    t.string   "guid",                  :null => false
    t.text     "url",                   :null => false
    t.string   "diaspora_handle",       :null => false
    t.text     "serialized_public_key", :null => false
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mongo_id"
  end

  add_index "people", ["diaspora_handle"], :name => "index_people_on_diaspora_handle", :unique => true
  add_index "people", ["guid"], :name => "index_people_on_guid", :unique => true
  add_index "people", ["mongo_id"], :name => "index_people_on_mongo_id"
  add_index "people", ["owner_id"], :name => "index_people_on_owner_id", :unique => true

  create_table "post_visibilities", :force => true do |t|
    t.integer  "post_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id", :null => false
  end

  add_index "post_visibilities", ["contact_id", "post_id"], :name => "index_post_visibilities_on_contact_id_and_post_id", :unique => true
  add_index "post_visibilities", ["contact_id"], :name => "index_post_visibilities_on_contact_id"
  add_index "post_visibilities", ["post_id"], :name => "index_post_visibilities_on_post_id"

  create_table "posts", :force => true do |t|
    t.integer  "author_id",                            :null => false
    t.boolean  "public",            :default => false, :null => false
    t.string   "diaspora_handle"
    t.string   "guid",                                 :null => false
    t.boolean  "pending",           :default => false, :null => false
    t.string   "type",                                 :null => false
    t.text     "text"
    t.integer  "status_message_id"
    t.text     "remote_photo_path"
    t.string   "remote_photo_name"
    t.string   "random_string"
    t.string   "processed_image"
    t.text     "youtube_titles"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mongo_id"
    t.string   "unprocessed_image"
  end

  add_index "posts", ["author_id"], :name => "index_posts_on_person_id"
  add_index "posts", ["guid"], :name => "index_posts_on_guid", :unique => true
  add_index "posts", ["mongo_id"], :name => "index_posts_on_mongo_id"
  add_index "posts", ["status_message_id", "pending"], :name => "index_posts_on_status_message_id_and_pending"
  add_index "posts", ["status_message_id"], :name => "index_posts_on_status_message_id"
  add_index "posts", ["type", "pending", "id"], :name => "index_posts_on_type_and_pending_and_id"
  add_index "posts", ["type"], :name => "index_posts_on_type"

  create_table "profiles", :force => true do |t|
    t.string   "diaspora_handle"
    t.string   "first_name",       :limit => 127
    t.string   "last_name",        :limit => 127
    t.string   "image_url"
    t.string   "image_url_small"
    t.string   "image_url_medium"
    t.date     "birthday"
    t.string   "gender"
    t.text     "bio"
    t.boolean  "searchable",                      :default => true, :null => false
    t.integer  "person_id",                                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mongo_id"
    t.string   "location"
  end

  add_index "profiles", ["first_name", "last_name", "searchable"], :name => "index_profiles_on_first_name_and_last_name_and_searchable"
  add_index "profiles", ["first_name", "searchable"], :name => "index_profiles_on_first_name_and_searchable"
  add_index "profiles", ["last_name", "searchable"], :name => "index_profiles_on_last_name_and_searchable"
  add_index "profiles", ["mongo_id"], :name => "index_profiles_on_mongo_id"
  add_index "profiles", ["person_id"], :name => "index_profiles_on_person_id", :unique => true

  create_table "requests", :force => true do |t|
    t.integer  "sender_id",    :null => false
    t.integer  "recipient_id", :null => false
    t.integer  "aspect_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mongo_id"
  end

  add_index "requests", ["mongo_id"], :name => "index_requests_on_mongo_id"
  add_index "requests", ["recipient_id"], :name => "index_requests_on_recipient_id"
  add_index "requests", ["sender_id", "recipient_id"], :name => "index_requests_on_sender_id_and_recipient_id", :unique => true
  add_index "requests", ["sender_id"], :name => "index_requests_on_sender_id"

  create_table "service_users", :force => true do |t|
    t.string   "uid",           :null => false
    t.string   "name",          :null => false
    t.string   "photo_url",     :null => false
    t.integer  "service_id",    :null => false
    t.integer  "person_id"
    t.integer  "contact_id"
    t.integer  "request_id"
    t.integer  "invitation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_users", ["service_id"], :name => "index_service_users_on_service_id"
  add_index "service_users", ["uid", "service_id"], :name => "index_service_users_on_uid_and_service_id", :unique => true

  create_table "services", :force => true do |t|
    t.string   "type",          :null => false
    t.integer  "user_id",       :null => false
    t.string   "uid"
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mongo_id"
    t.string   "user_mongo_id"
  end

  add_index "services", ["mongo_id"], :name => "index_services_on_mongo_id"
  add_index "services", ["user_id"], :name => "index_services_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", :limit => 127
    t.integer  "tagger_id"
    t.string   "tagger_type",   :limit => 127
    t.string   "context",       :limit => 127
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"
  add_index "taggings", ["taggable_id", "taggable_type", "tag_id"], :name => "index_taggings_uniquely", :unique => true

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_preferences", :force => true do |t|
    t.string   "email_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.text     "serialized_private_key"
    t.integer  "invites",                               :default => 0,     :null => false
    t.boolean  "getting_started",                       :default => true,  :null => false
    t.boolean  "disable_mail",                          :default => false, :null => false
    t.string   "language"
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                         :default => "",    :null => false
    t.string   "invitation_token",       :limit => 20
    t.datetime "invitation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mongo_id"
    t.string   "invitation_service"
    t.string   "invitation_identifier"
    t.text     "open_aspects"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["invitation_service", "invitation_identifier"], :name => "index_users_on_invitation_service_and_invitation_identifier", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["mongo_id"], :name => "index_users_on_mongo_id"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  add_foreign_key "aspect_memberships", "aspects", :name => "aspect_memberships_aspect_id_fk"
  add_foreign_key "aspect_memberships", "contacts", :name => "aspect_memberships_contact_id_fk", :dependent => :delete

  add_foreign_key "aspect_visibilities", "aspects", :name => "aspect_visibilities_aspect_id_fk", :dependent => :delete
  add_foreign_key "aspect_visibilities", "posts", :name => "aspect_visibilities_post_id_fk", :dependent => :delete

  add_foreign_key "comments", "people", :name => "comments_author_id_fk", :column => "author_id", :dependent => :delete
  add_foreign_key "comments", "posts", :name => "comments_post_id_fk", :dependent => :delete

  add_foreign_key "contacts", "people", :name => "contacts_person_id_fk", :dependent => :delete

  add_foreign_key "invitations", "users", :name => "invitations_recipient_id_fk", :column => "recipient_id", :dependent => :delete
  add_foreign_key "invitations", "users", :name => "invitations_sender_id_fk", :column => "sender_id", :dependent => :delete

  add_foreign_key "likes", "people", :name => "likes_author_id_fk", :column => "author_id"
  add_foreign_key "likes", "posts", :name => "likes_post_id_fk"

  add_foreign_key "notification_actors", "notifications", :name => "notification_actors_notification_id_fk", :dependent => :delete

  add_foreign_key "post_visibilities", "contacts", :name => "post_visibilities_contact_id_fk", :dependent => :delete
  add_foreign_key "post_visibilities", "posts", :name => "post_visibilities_post_id_fk", :dependent => :delete

  add_foreign_key "posts", "people", :name => "posts_author_id_fk", :column => "author_id", :dependent => :delete

  add_foreign_key "profiles", "people", :name => "profiles_person_id_fk", :dependent => :delete

  add_foreign_key "requests", "people", :name => "requests_recipient_id_fk", :column => "recipient_id", :dependent => :delete
  add_foreign_key "requests", "people", :name => "requests_sender_id_fk", :column => "sender_id", :dependent => :delete

  add_foreign_key "services", "users", :name => "services_user_id_fk", :dependent => :delete

end
