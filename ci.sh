#!/bin/bash
 
echo "*************************************************************************************************" &&
echo "*     t                             ruby 1.8.7     build                                        *" &&
echo "*************************************************************************************************" &&
echo "" &&
bundle install &&
#RAILS_ENV=development rake db:migrate
#bundle exec rake spec SPEC_OPTS="--tag ~performance"
#cp config/application.yml.example config/application.yml &&
#bundle exec rake cruise
bundle exec rake spec SPEC_OPTS="--tag ~performance"
