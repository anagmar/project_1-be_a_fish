require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/diver.rb' )
also_reload( '../models/*' )

#Index
get ('/divers') do
  @divers = Diver.all()
  erb(:"divers/index")
end

#new
get ('/divers/new')do
erb(:"divers/new")
end

#Show
get ('/divers/:id') do
  id = params[:id].to_i()
  @diver = Diver.find(id)
  erb (:"divers/show")
end

#create
post ('/divers') do
  @diver = Diver.new(params)
  @diver.save
  redirect to '/divers'
end

#edit
get ('/divers/:id/edit') do
  id = params[:id].to_i
  @diver = Diver.find(id)
  erb(:"divers/edit")
end

#UPDATE
post ('/divers/:id') do
  diver = Diver.new(params)
  diver.update
  redirect to '/divers'
end

#DELETE
post ('/divers/:id/delete') do
  diver = Diver.find(params[:id].to_i)
  diver.delete
 redirect to '/divers'
end
