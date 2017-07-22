# worker processes Integer(ENV["WEB_CONCURRENCY"] || 3)
# timeout 15
# preload_app true

# before_fork do |server, worker|
# 	Signal.trap 'TERM' do 
# 		puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
# 		Process.kill 'QUIT', Process.pid
# 	end

# 	defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
# end

# after_fork do |server, worker|
# 	Signal.trap 'TERM' do 
# 		msg = 'Unicorn worker intercepting TERM and doing nothing. '
# 		msg += 'Wait for master to send QUIT'
# 		puts msg
# 	end

# 	defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
# end

environment = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'production'

# Save on RAM while in development
if environment == 'development'
  worker_processes 1
else
  worker_processes 4
end

timeout 30
preload_app true

before_fork do |server, worker|
  # Close all open connections
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  @resque_pid ||= spawn("bundle exec rake resque:work QUEUES=fast")
end

after_fork do |server, worker|
  # Reopen all connections
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end