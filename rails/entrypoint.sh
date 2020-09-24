#!/bin/bash

bundle exec rails db:setup;
bundle exec rails db:seed;
bundle exec rails s -b 0.0.0.0;