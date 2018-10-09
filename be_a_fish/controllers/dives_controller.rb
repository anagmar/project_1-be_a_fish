require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/dives.rb' )
also_reload( '../models/*' )

#index
get ('/dives') do
  @dives = Dive.all()
  erb(:"dives/index")
end

#new
get ('/dives/new')do
erb(:"dives/new")
end
#
#show
get ('/dives/:id') do
  id = params[:id].to_i()
  @dive = Dive.find(id)
  erb (:"dives/show")
end

# #create
post ('/dives') do
  @dive = Dive.new(params)
  @dive.save
  redirect to '/dives'
end
#
#edit
get ('/dives/:id/edit') do
  id = params[:id].to_i
  @dive = Dive.find(id)
  erb(:"dives/edit")
end
#
# #update
post ('/dives/:id') do
  dive = Dive.new(params)
  dive.update
  redirect to '/dives'
end
#
#delete
post ('/dives/:id/delete') do
  dive = Dive.find(params[:id].to_i)
  dive.delete
  redirect to '/dives'
end
