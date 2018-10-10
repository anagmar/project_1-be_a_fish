require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/schedule.rb' )
require_relative( '../models/diver.rb' )
require_relative( '../models/booking.rb' )

also_reload( '../models/*' )


#index
get ('/bookings') do
  @bookings = Booking.all()
  erb(:"booking/index")
end

#show
get ('/bookings/:id')do
  id = params[:id].to_i()
  @booking = Booking.find(id)
  erb (:"booking/show")
end
# #new
get ('/bookings/new')do
  @divers = Diver.all()
  @schedules = Schedule.all()
  @bookings = Booking.all()
  erb(:"booking/new")
end
#
# #Create
get('/bookings')do
  booking = Booking.new(params)
  booking.save
  redirect to '/schedules'
end


#edit

#Update

#delete
