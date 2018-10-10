require_relative('../db/sql_runner')
require_relative('diver.rb')
require_relative('schedule.rb')

class Booking

  attr_reader :id, :diver_id, :schedule_id


  def initialize(options)
    @id = options['id'].to_i
    @diver_id = options['diver_id'].to_i
    @schedule_id = options['schedule_id'].to_i
  end


  def divers()
    sql  = "SELECT *
        FROM divers
        WHERE id = $1"
    values = [@diver_id]
    result = SqlRunner.run(sql,values)
    diver = Diver.new(result.first)
    return diver
  end


#Create
  def save()
      sql = "INSERT INTO bookings (
        diver_id,
        schedule_id
        )
        VALUES ( $1, $2)
        RETURNING id"
      values = [@diver_id, @schedule_id]
      booking = SqlRunner.run(sql,values)
      @id = booking[0]['id'].to_i
  end

#schedule
  def schedule()
    sql  = "SELECT *
        FROM schedules
        WHERE id = $1"
    values = [@schedule_id]
    result = SqlRunner.run(sql,values)
    schedule = Schedule.new(result.first)
    return schedule
  end




#Read
  def self.all()
    sql = "SELECT * FROM bookings"
    bookings = SqlRunner.run(sql)
    return Booking.map_items(bookings)
  end

#Find
  def self.find(id)
    sql = "SELECT * FROM bookings
          WHERE id = $1"
    values  = [id]
    result = SqlRunner.run(sql,values)
    return Booking.new(result.first)

  end

#Update
  def update()
    sql = "UPDATE bookings SET(
    diver_id,
    schedule_id
    ) = ($1, $2)
    WHERE id = $3; "
    values = [ @diver_id, @schedule_id, @id]
    SqlRunner.run(sql, values)
  end

#Delete ALL
  def self.delete_all()
    sql = "DELETE FROM bookings"
    SqlRunner.run(sql)
  end

#Delete connect
  def delete()
    sql = "DELETE FROM bookings
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

#Helper methods
  def self.map_items(diver_data)
    result = diver_data.map do |divers_data|
    Booking.new(divers_data)
    end
    return result
  end



end
