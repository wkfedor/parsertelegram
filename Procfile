web: bundle exec rails s -p 3002  -P tmp/pids/server2.pid
worker: rake resque:work QUEUE=maxcount
servis: bundle exec ruby ../microone.rb
