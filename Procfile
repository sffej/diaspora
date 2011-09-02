web:       bundle exec rails s thin -p $PORT
redis:     redis-server config/redis.conf
websocket: ruby script/websocket_server.rb
worker:    COUNT=9 QUEUE=* rake resque:workers
