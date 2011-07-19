#!/bin/bash
 
echo "*************************************************************************************************" &&
echo "*                                  ruby 1.8.7     build                                        *" &&
echo "*************************************************************************************************" &&
echo "" &&
bundle install &&
RAILS_ENV=development rake db:migrate
cp config/application.yml.example config/application.yml &&
bundle exec rake spec SPEC_OPTS="--tag ~performance"
