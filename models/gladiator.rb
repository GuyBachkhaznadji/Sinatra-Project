require_relative('../db/sql_runner.rb')

class Gladiator

  attr_accessor(:name, :type, :type_id, :level, :exp, :max_health, :current_health, :attack, :defence, :speed)
  attr_reader(:id)

  def initialize(details)
    @id = details['id'].to_i if details['id'].to_i 
    @name = details['name']
    @type = "Gladiator"
    @level = details['level'].to_i ? details['level'].to_i : 1
    @exp = details['exp'].to_i ? details['exp'].to_i : 0
    creature_type = self.get_creature_type
    @type_id = creature_type.id.to_i
    @max_health = creature_type.starting_health.to_i
    @current_health = @max_health
    @attack = creature_type.starting_attack.to_i
    @defence = creature_type.starting_defence.to_i
    @speed = creature_type.starting_speed.to_i
  end

  def get_creature_type()
    sql = "SELECT * FROM creature_types
    WHERE $1 = name;"
    values = [@type]
    return CreatureType.map_items(sql, values)[0]
  end

  def save()
    sql = "INSERT INTO gladiators
    (name, level, exp, type_id, max_health, current_health, attack, defence, speed)
    VALUES 
    ($1, $2, $3, $4, $5, $6, $7, $8, $9)
    RETURNING id;"
    values = [@name, @level, @exp, @type_id, @max_health, @current_health, @attack, @defence, @speed]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE gladiators
    SET 
    name = $1,
    level = $2,
    exp = $3,
    type_id = $4,
    max_health = $5,
    current_health = $6,
    attack = $7,
    defence = $8,
    speed = $9
    WHERE id = $10;"
    values = [@name, @level, @exp, @type_id, @max_health, @current_health, @attack, @defence, @speed, @id]
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

  def self.all()
    sql = "SELECT * FROM gladiators;"
    values = nil
    self.map_items(sql, values)
  end

  def self.map_items(sql, values)
    gladiators_hash = SqlRunner.run(sql, values)
    result = gladiators_hash.map { |gladiator| Gladiator.new(gladiator)}
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