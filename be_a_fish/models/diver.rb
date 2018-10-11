require_relative('../db/sql_runner')
require_relative('dives.rb')

class Diver

  attr_reader :id
  attr_accessor :name, :level


  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @level = options['level']
  end

#Create
  def save()
      sql = "INSERT INTO divers (
        name,
        level
        )
        VALUES ( $1, $2)
        RETURNING id"
      values = [@name, @level]
      diver = SqlRunner.run(sql,values)
      @id = diver[0]['id'].to_i
  end

#Fit for Dive
  def fit?(dive)
    if @level == "Open Water" && dive.difficulty == "Easy"
      return "Fit for Dive"
    elsif @level == "Advanced" && dive.difficulty == ("Advanced" || "Easy")
      return "Fit for Dive"
   elsif @level == "Master Diver" && dive.difficulty == ("Advanced" || "Easy" || "Challenging")
     return "Fit for Dive"
   else
     return "Not at the level of the dive. Check with Dive Leader."
   end
  end




#dives done
def dives_booked()
  sql  = "SELECT dives.*
      FROM dives
      INNER JOIN schedules
      ON dives.id = schedules.dive_id
      INNER JOIN bookings
      ON bookings.schedule_id = schedules.id
      WHERE bookings.diver_id = $1"
  values = [@id]
  result = SqlRunner.run(sql,values)
  dives = Dive.map_items(result)
  return dives
end


#see the schedule of each diver
def dives_scheduled()
  sql  = "SELECT schedules.*
      FROM schedules
      INNER JOIN bookings
      ON schedules.id = bookings.schedule_id
      WHERE bookings.diver_id = $1"
  values = [@id]
  result = SqlRunner.run(sql,values)
  dives = Schedule.map_items(result)
  return dives
end



#bookigns
def diver_bookings()
  sql  = "SELECT *
      FROM bookings
      WHERE bookings.diver_id = $1"
  values = [@id]
  result = SqlRunner.run(sql,values)
  dives = Booking.map_items(result)
  return dives
end

#difficulty_of_dive
def one_dive()
    sql  = "SELECT dives.*
            FROM dives
            INNER JOIN schedules
            ON schedules.dive_id = dives.id
            INNER JOIN bookings
            ON schedules.id = bookings.schedule_id
            WHERE bookings.diver_id = $1"
    values = [@id]
    result = SqlRunner.run(sql,values)
    dive = Dive.map_items(result)
    return dive.first
  end


#Read
  def self.all()
    sql = "SELECT * FROM divers"
    divers = SqlRunner.run(sql)
    return Diver.map_items(divers)
  end

#Find
  def self.find(id)
    sql = "SELECT * FROM divers
          WHERE id = $1"
    values  = [id]
    result = SqlRunner.run(sql,values)
    return Diver.new(result.first)

  end

#Update
  def update()
    sql = "UPDATE divers SET(
    name,
    level
    ) = ($1, $2)
    WHERE id = $3"
    values = [@name, @level, @id]
    SqlRunner.run(sql, values)
  end

#Delete ALL
  def self.delete_all()
    sql = "DELETE FROM divers"
    SqlRunner.run(sql)
  end

#Delete connect
  def delete
    sql = "DELETE FROM divers
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

#Helper methods
  def self.map_items(diver_data)
    result = diver_data.map do |divers_data|
    Diver.new(divers_data)
    end
    return result
  end
  def self.map_items(diver_data)
    result = diver_data.map do |divers_data|
    Diver.new(divers_data)
    end
    return result
  end


end
