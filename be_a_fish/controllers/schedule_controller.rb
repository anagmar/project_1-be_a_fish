require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/schedule.rb' )
require_relative( '../models/dives.rb' )

also_reload( '../models/*' )

#index)
get ('/schedules') do
  @schedules = Schedule.all
  erb(:"schedule/index")
end

#new
get ('/schedules/new')do
  @dives = Dive.all()
  @schedules = Schedule.all()
  erb(:"schedule/new")
end

#show
get ('/schedules/:id')do
  id = params[:id].to_i()
  @schedule = Schedule.find(id)
  erb (:"schedule/show")
end

#create
post ('/schedules')do
  schedule = Schedule.new(params)
  schedule.save
  redirect to '/schedules'
end

#edit
get ('/schedules/:id/edit') do
  id = params[:id].to_i
  @schedule = Schedule.find(id)
  erb(:"schedule/edit")
end

#update
post('/schedules/:id')do
  schedule = Schedule.new(params)
  schedule.update
  redirect to '/schedules'
end

#delete
post ('/schedules/:id/delete') do
  id = params[:id].to_i
  schedule = Schedule.find(id)
  schedule.delete
  redirect to '/schedules'
end
