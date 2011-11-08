web:       bundle exec rails s thin -p $PORT
redis:     redis-server config/redis.conf
websocket: ruby script/websocket_server.rb
worker:    QUEUE=* bundle exec rake resque:work
