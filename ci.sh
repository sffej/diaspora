#!/bin/bash

echo "*************************************************************************************************" &&
echo "*                                  ruby 1.8.7 REE build                                         *" &&
echo "*************************************************************************************************" &&
echo "" &&
bundle install &&
RAILS_ENV=test rake db:migrate
bundle exec rake spec SPEC_OPTS="--tag ~performance"
