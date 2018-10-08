require_relative('../db/sql_runner')

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



end
