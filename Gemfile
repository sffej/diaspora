source 'https://rubygems.org'
#diasporg gems
gem 'god'
#gem 'newrelic_rpm'
#diasporg end

gem "rails", "4.2.8"

# Legacy Rails features, remove me!
# responders (class level)
gem "responders", "2.3.0"

# Appserver

gem "unicorn", "5.2.0", require: false
gem "unicorn-worker-killer", "0.4.4"

# Federation

gem "diaspora_federation-rails", "0.1.8"

# API and JSON

gem "acts_as_api", "1.0.0"
gem "json",        "1.8.6"
gem "json-schema", "2.8.0"

# Authentication

gem "devise", "4.2.0"
gem "devise_lastseenable", "0.0.6"

# Captcha

gem "simple_captcha2", "0.4.3", require: "simple_captcha"

# Background processing

gem "sidekiq", "4.2.9"

# Scheduled processing

gem "sidekiq-cron", "0.4.5"

# Compression

gem "uglifier", "3.1.2"

# Configuration

gem "configurate", "0.3.1"

# Cross-origin resource sharing

gem "rack-cors", "0.4.1", require: "rack/cors"

# CSS

gem "autoprefixer-rails",     "6.7.6"
gem "bootstrap-sass",         "3.3.7"
gem "bootstrap-switch-rails", "3.3.3"
gem "compass-rails",          "2.0.5"
gem "sass-rails",             "5.0.6"

# Database

group :mysql, optional: true do
  gem "mysql2", "0.4.5"
end
group :postgresql, optional: true do
  gem "pg",     "0.19.0"
end


gem "activerecord-import", "0.17.1"

# File uploading

gem "fog-aws",     "1.2.1"
gem "carrierwave", "0.11.2"
gem "mini_magick", "4.6.1"

# GUID generation
gem "uuid", "2.3.8"

# Icons

gem "entypo-rails", "3.0.0"

# JavaScript

gem "handlebars_assets", "0.23.1"
gem "jquery-rails",      "4.2.1"
gem "jquery-ui-rails",   "5.0.5"
gem "js-routes",         "1.3.3"
gem "js_image_paths",    "0.1.0"

source "https://rails-assets.org" do
  gem "rails-assets-jquery",                              "2.2.4" # Should be kept in sync with jquery-rails

  gem "rails-assets-highlightjs",                         "9.9.0"
  gem "rails-assets-markdown-it",                         "8.3.0"
  gem "rails-assets-markdown-it-hashtag",                 "0.4.0"
  gem "rails-assets-markdown-it-diaspora-mention",        "1.1.1"
  gem "rails-assets-markdown-it-sanitizer",               "0.4.3"
  gem "rails-assets-markdown-it--markdown-it-for-inline", "0.1.1"
  gem "rails-assets-markdown-it-sub",                     "1.0.0"
  gem "rails-assets-markdown-it-sup",                     "1.0.0"

  gem "rails-assets-backbone",                            "1.3.3"
  gem "rails-assets-bootstrap-markdown",                  "2.10.0"
  gem "rails-assets-corejs-typeahead",                    "1.1.1"
  gem "rails-assets-fine-uploader",                       "5.13.0"

  # jQuery plugins

  gem "rails-assets-autosize",                            "3.0.20"
  gem "rails-assets-blueimp-gallery",                     "2.25.0"
  gem "rails-assets-jquery-placeholder",                  "2.3.1"
  gem "rails-assets-jquery-textchange",                   "0.2.3"
  gem "rails-assets-perfect-scrollbar",                   "0.6.16"
end

# Localization

gem "http_accept_language", "2.1.0"
gem "i18n-inflector-rails", "1.0.7"
gem "rails-i18n",           "4.0.8"

# Mail

gem "markerb",             "1.1.0"

# Map
gem "leaflet-rails",       "0.7.7"

# Parsing

gem "nokogiri",          "1.7.1"
gem "open_graph_reader", "0.6.2" # also update User-Agent in features/support/webmock.rb
gem "redcarpet",         "3.4.0"
gem "ruby-oembed",       "0.10.1"
gem "twitter-text",      "1.14.5"

# RTL support

gem "string-direction", "1.2.0"

# Security Headers

gem "secure_headers", "3.6.1"

# Services

gem "omniauth",           "1.4.2"
gem "omniauth-facebook",  "4.0.0"
gem "omniauth-tumblr",    "1.2"
gem "omniauth-twitter",   "1.4.0"
gem "twitter",            "6.1.0"
gem "omniauth-wordpress", "0.2.2"

# OpenID Connect
gem "openid_connect", "0.12.0"

# Serializers

gem "active_model_serializers", "0.9.5"

# XMPP chat dependencies
gem "diaspora-prosody-config",    "0.0.7"
gem "rails-assets-diaspora_jsxc", "0.1.5.develop.7", source: "https://rails-assets.org"

# Tags

gem "acts-as-taggable-on", "3.5.0"

# URIs and HTTP

gem "addressable",        "2.5.0", require: "addressable/uri"
gem "faraday",            "0.11.0" # also update User-Agent in OpenID specs
gem "faraday_middleware", "0.11.0.1"
gem "faraday-cookie_jar", "0.0.6"
gem "typhoeus",           "1.1.2"

# Views

gem "gon",                     "6.1.0"
gem "hamlit",                  "2.8.0"
gem "mobile-fu",               "1.3.1"
gem "will_paginate",           "3.1.5"
gem "rails-timeago",           "2.11.0"

# Logging

gem "logging-rails", "0.5.0", require: "logging/rails"

# Reading and writing zip files

gem "rubyzip", "1.2.1", require: "zip"

# Prevent occasions where minitest is not bundled in
# packaged versions of ruby. See following issues/prs:
# https://github.com/gitlabhq/gitlabhq/issues/3826
# https://github.com/gitlabhq/gitlabhq/pull/3852
# https://github.com/discourse/discourse/pull/238
gem "minitest"

gem "versionist", "1.5.0"

# Prevent accidental upgrades of thor
# TODO: remove this when either all gems depending on thor have fixed the warnings
#       or thor released a version where they are clearly marked as warnings
# see: https://github.com/erikhuda/thor/issues/538
gem "thor", "0.19.1"

# Windows and OSX have an execjs compatible runtime built-in, Linux users should
# install Node.js or use "therubyracer".
#
# See https://github.com/sstephenson/execjs#readme for more supported runtimes

# gem "therubyracer", :platform => :ruby

group :production do # we don"t install these on travis to speed up test runs
  # Administration

  gem "rails_admin", "1.1.0"

  # Analytics

  gem "rack-google-analytics", "1.2.0"
  gem "rack-piwik",            "0.3.0",  require: "rack/piwik"

  # Process management

  gem "eye", "0.9.1"

  # Redirects

  gem "rack-rewrite", "1.5.1", require: false
  gem "rack-ssl",     "1.4.1", require: "rack/ssl"

  # Third party asset hosting

  gem "asset_sync", "2.0.0", require: false
end

group :development do
  # Automatic test runs
  gem "guard",          "2.14.1", require: false
  gem "guard-cucumber", "2.1.2", require: false
  gem "guard-rspec",    "4.7.3", require: false
  gem "guard-rubocop",  "1.2.0", require: false
  gem "rb-fsevent",     "0.9.8", require: false
  gem "rb-inotify",     "0.9.8", require: false

  # Linters
  gem "haml_lint",      "0.21.0"
  gem "pronto",         "0.8.2"
  gem "pronto-eslint",  "0.8.0"
  gem "pronto-haml",    "0.8.0"
  gem "pronto-rubocop", "0.8.0"
  gem "pronto-scss",    "0.8.0", require: false
  gem "rubocop",        "0.47.1"

  # Preloading environment

  gem "spring", "2.0.1"
  gem "spring-commands-rspec", "1.0.4"
  gem "spring-commands-cucumber", "1.0.1"

  # Debugging
  gem "pry"
  gem "pry-byebug"

  # test coverage
  gem "simplecov", "0.12.0", require: false

  gem "turbo_dev_assets", "0.0.2"
end

group :test do
  # RSpec (unit tests, some integration tests)

  gem "fixture_builder",   "0.4.1"
  gem "fuubar",            "2.2.0"
  gem "test_after_commit", "1.1.0"

  # Cucumber (integration tests)

  gem "capybara",           "2.12.1"
  gem "database_cleaner",   "1.5.3"
  gem "poltergeist",        "1.13.0"

  gem "cucumber-api-steps", "0.13", require: false
  gem "json_spec", "1.1.4"

  # General helpers

  gem "factory_girl_rails", "4.8.0"
  gem "timecop",            "0.8.1"
  gem "webmock",            "2.3.2", require: false
  gem "shoulda-matchers",   "3.1.1"

  gem "diaspora_federation-test", "0.1.8"

  # Coverage
  gem 'coveralls', require: false
end

group :development, :test do
  # RSpec (unit tests, some integration tests)
  gem "rspec-rails", "3.5.2"

  # Cucumber (integration tests)
  gem "cucumber-rails", "1.4.5", require: false

  # Jasmine (client side application tests (JS))
  gem "jasmine",                   "2.5.2"
  gem "jasmine-jquery-rails",      "2.0.3"
  gem "rails-assets-jasmine-ajax", "3.3.1", source: "https://rails-assets.org"
  gem "sinon-rails",               "1.15.0"

  # silence assets
  gem "quiet_assets", "1.1.0"
end
