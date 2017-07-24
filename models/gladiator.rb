require_relative('../db/sql_runner.rb')
require_relative('./creature_type')

class Gladiator

  attr_accessor(:name, :type_id, :level, :exp, :max_health, :current_health, :attack, :defence, :speed)
  attr_reader(:id)

  def initialize(details, creature_type)
    @id = details['id'].to_i
    @name = details['name']
    @type_id = creature_type.id.to_i
    @level = details['level'].to_i
    @exp = details['exp'].to_i
    @max_health = creature_type.starting_health.to_i
    @current_health = @max_health
    @attack = creature_type.starting_attack.to_i
    @defence = creature_type.starting_defence.to_i
    @speed = creature_type.starting_speed.to_i
  end

  def save()
    sql = "INSERT INTO gladiators
    (name, type_id, level, exp, max_health, current_health, attack, defence, speed)
    VALUES 
    ($1, $2, $3, $4, $5, $6, $7, $8, $9)
    RETURNING id;"
    values = [@name, @type_id, @level, @exp, @max_health, @current_health, @attack, @defence, @speed]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE gladiators
    SET 
    name = $1
    WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM gladiators
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def creatures()
    sql = "SELECT * FROM creatures
    WHERE $1 = gladiator_id;"
    values = [@id]
    return Creature.map_items(sql, values)
  end

  def get_creature_type
    sql = "SELECT * FROM creature_types
    WHERE $1 = id;"
    values = [@type_id]
    return CreatureType.map_items(sql, values)[0]
  end

  def find_creature_type(type_id)
    sql = "SELECT * FROM creature_types
    WHERE $1 = id;"
    values = [type_id]
    return CreatureType.map_items(sql, values)[0]
  end

  def self.all()
    sql = "SELECT * FROM gladiators;"
    values = nil
    self.map_items(sql, values)
  end

  def self.map_items(sql, values)
    gladiators_hash = SqlRunner.run(sql, values)
    type_id = gladiators_hash[0]['type_id'].to_i
    creature_type = self.find_creature_type(type_id)
    result = gladiators_hash.map { |gladiator| Gladiator.new(gladiator, creature_type)}
    return result
  end

  def self.delete_all()
    sql = 'DELETE FROM gladiators'
    values = nil
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM gladiators
    WHERE id = $1"
    values = [id]
    gladiator = self.map_items(sql, values)[0]
    return gladiator
  end

end