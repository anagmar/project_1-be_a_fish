require_relative('../db/sql_runner')

class Dive

  attr_reader :id
  attr_accessor :location, :difficulty


  def initialize(options)
    @id = options['id'].to_i
    @location = options['location']
    @difficulty = options['difficulty']
  end

#divers

  def divers()
    sql  = "SELECT divers.*
        FROM divers
        INNER JOIN bookings
        ON divers.id = bookings.diver_id
        INNER JOIN schedules
        ON schedules.id = bookings.schedule_id
        WHERE schedules.dive_id = $1"
    values = [@id]
    result = SqlRunner.run(sql,values)
    divers = Diver.map_items(result)
    return divers
  end




#Create
  def save()
      sql = "INSERT INTO dives (
        location,
        difficulty
        )
        VALUES ( $1, $2)
        RETURNING id"
      values = [@location, @difficulty]
      dive = SqlRunner.run(sql,values)
      @id = dive[0]['id'].to_i
  end

#Read
  def self.all()
    sql = "SELECT * FROM dives"
    dives = SqlRunner.run(sql)
    return Dive.map_items(dives)
  end

#Find
  def self.find(id)
    sql = "SELECT * FROM dives
          WHERE id = $1"
    values  = [id]
    result = SqlRunner.run(sql,values)
    return Dive.new(result.first)

  end

#Update
  def update()
    sql = "UPDATE dives SET(
    location,
    difficulty
    ) = ($1, $2)
    WHERE id = $3"
    values = [@location, @difficulty, @id]
    SqlRunner.run(sql, values)
  end

#Delete ALL
  def self.delete_all()
    sql = "DELETE FROM dives"
    SqlRunner.run(sql)
  end

#Delete connect
  def delete()
    sql = "DELETE FROM dives
           WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql,values)
  end

#Helper methods
  def self.map_items(diver_data)
    result = diver_data.map do |divers_data|
    Dive.new(divers_data)
    end
    return result
  end



end
