#!/bin/bash
service memcached start
cd /app && TZ='Asia/Tokyo' bundle exec unicorn -E production -c /app/unicorn.rb
