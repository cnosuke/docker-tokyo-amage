nginx: /usr/sbin/nginx -c /etc/nginx/nginx.conf -g "daemon off;"
memcached: /usr/bin/memcached -m 1024 -p 11211 -u memcache -l 127.0.0.1 -I 20m
app: TZ='Asia/Tokyo' bundle exec unicorn -E production -c /app/unicorn.rb
