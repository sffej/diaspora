#!/bin/bash

echo "*************************************************************************************************" &&
echo "*    f                              ruby 1.8.7 REE build                                         *" &&
echo "*************************************************************************************************" &&
echo "" &&
bundle install &&
RAILS_ENV=development rake db:migrate
bundle exec rake spec SPEC_OPTS="--tag ~performance"
