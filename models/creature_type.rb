require_relative('../db/sql_runner.rb')

class CreatureType

  attr_accessor(:name, :starting_health, :starting_attack, :starting_defence, :starting_speed)
  attr_reader(:id)

  def initialize(details)
    @id = details['id'].to_i if details['id'].to_i
    @name = details['name']
    @starting_health = details['starting_health'].to_i
    @starting_attack = details['starting_attack'].to_i
    @starting_defence = details['starting_defence'].to_i
    @starting_speed = details['starting_speed'].to_i
  end

  def save()
    sql = "INSERT INTO creature_types
    (name, starting_health, starting_attack, starting_defence, starting_speed)
    VALUES 
    ($1, $2, $3, $4, $5)
    RETURNING id;"
    values = [@name, @starting_health, @starting_attack, @starting_defence, @starting_speed]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE creature_types
    SET 
    name = $1, 
    starting_health = $2, 
    starting_attack = $3,
    starting_defence = $4,
    starting_speed = $5,
    WHERE id = $6;"
    values = [@name, @starting_health, @starting_attack, @starting_defence, @starting_speed, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM creature_types
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM creature_types"
    values = nil
    SqlRunner.run(sql, values)
  end

  def self.map_items(sql, values)
    creatures_type_hash = SqlRunner.run(sql, values)
    result = creatures_type_hash.map { |creature_type| CreatureType.new(creature_type)}
    return result
  end

end