require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/diver_controller.rb')
require_relative('controllers/dives_controller.rb')
require_relative('controllers/schedule_controller.rb')

get ('/') do
  erb(:index)
end
