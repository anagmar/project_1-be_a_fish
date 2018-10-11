require( 'sinatra' )
require( 'sinatra/contrib/all' )
require('pry')
require_relative( '../models/schedule.rb' )
require_relative( '../models/diver.rb' )
require_relative( '../models/booking.rb' )

also_reload( '../models/*' )


#index
get ('/bookings') do
  @bookings = Booking.all()
  erb(:"booking/index")
end

get ('/bookings/new')do
  @divers = Diver.all()
  @schedules = Schedule.all()
  @bookings = Booking.all()
  erb(:"booking/new")
end



#show
get ('/bookings/:id')do
  id = params[:id].to_i()
  @booking = Booking.find(id)
  erb (:"booking/show")
end

#create a new booking for a specific divers
get ("/bookings/new/diver/:id")do
id = params[:id].to_i
@diver = Diver.find(id)
@schedules = Schedule.all()
erb(:"booking/new_booking")
end
#
#Create
post('/bookings')do
  booking = Booking.new(params)
  booking.save
  redirect to '/bookings'
end

#edit / cannot edit a booking !
post ('/bookings/:id/delete') do
  id = params[:id].to_i
  booking = Booking.find(id)
  booking.delete
  redirect to '/bookings'
end



#Update

#delete
