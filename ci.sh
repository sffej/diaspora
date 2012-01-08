#!/bin/bash
bundle install &&
RAILS_ENV=development rake db:migrate
cp config/application.yml.example config/application.yml &&
bundle exec rake db:test:prepare
bundle exec rake spec SPEC_OPTS="--tag ~performance"
echo "test"
