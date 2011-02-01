#!/bin/bash

echo "*************************************************************************************************" &&
echo "*                                  ruby 1.8.7 REE build                                         *" &&
echo "*************************************************************************************************" &&
echo "" &&
#rm -f Gemfile.lock &&
#source /usr/local/rvm/scripts/rvm &&
#rvm use ree@diaspora --create &&
bundle install &&
RAILS_ENV=test rake db:migrate
bundle exec rake spec
