require_relative('../db/sql_runner')
require_relative('dives.rb')

class Schedule

  attr_reader :id, :dive_id
  attr_accessor  :timing, :day, :empty_boat_spaces


  def initialize(options)
    @id = options['id'].to_i
    @dive_id= options['dive_id'].to_i
    @timing = options['timing']
    @day = options['day']
    @empty_boat_spaces = options['empty_boat_spaces'].to_i
  end

#Create
  def save()
      sql = "INSERT INTO schedules (
        dive_id,
        timing,
        day,
        empty_boat_spaces
        )
        VALUES ( $1, $2,$3,$4)
        RETURNING id"
      values = [@dive_id, @timing, @day, @empty_boat_spaces]
      schedule = SqlRunner.run(sql,values)
      @id = schedule[0]['id'].to_i
  end

#Session
def session()

  if timing == "09:30:00"
     return "Morning Session"
  else
     return "Afternoon Session"
  end
end




#dives in a schedule
def dives()
  sql  = "SELECT *
      FROM dives
      WHERE id = $1"
  values = [@dive_id]
  result = SqlRunner.run(sql,values)
  dives = Dive.new(result.first)
  return dives
end

def dives_location()
  sql  = "SELECT *
      FROM dives
      WHERE id = $1"
  values = [@dive_id]
  result = SqlRunner.run(sql,values)
  dives = Dive.map_items(result)
  return dives.location
end


#Read
  def self.all()
    sql = "SELECT * FROM schedules"
    schedules = SqlRunner.run(sql)
    return Schedule.map_items(schedules)
  end

#Find
  def self.find(id)
    sql = "SELECT * FROM schedules
          WHERE id = $1"
    values  = [id]
    result = SqlRunner.run(sql,values)
    return Schedule.new(result.first)

  end

#Update
  def update()
    sql = "UPDATE schedules SET(
    timing,
    day,
    empty_boat_spaces
    ) = ($1, $2, $3, $4)
    WHERE id = $5; "
    values = [ @timing,@day,@empty_boat_spaces, @id]
    SqlRunner.run(sql, values)
  end

#Delete ALL
  def self.delete_all()
    sql = "DELETE FROM schedules"
    SqlRunner.run(sql)
  end

#Delete connect
  def delete()
    sql = "DELETE FROM schedules
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

#Helper methods
  def self.map_items(diver_data)
    result = diver_data.map do |divers_data|
    Schedule.new(divers_data)
    end
    return result
  end



end
