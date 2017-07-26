require_relative('../db/sql_runner.rb')
require_relative('./creature_type.rb')

class Creature

  attr_accessor(:gladiator_id, :name, :capture_date, :fightable, :type, :type_id, :level, :exp, :max_health, :current_health, :attack, :defence, :speed)
  attr_reader(:id)

  def initialize(details)
    true_false = {'t' => true, 'f' => false}
    @id = details['id'].to_i if details['id'].to_i
    @gladiator_id = self.check_null(details['gladiator_id'])
    @name = details['name']
    @capture_date = details['capture_date']
    @fightable = true_false[details['fightable']]
    @level = details['level'] ? details['level'].to_i : 1
    @exp = details['exp'] ? details['exp'].to_i : 0
    @type = details['type']
    creature_type = self.get_creature_type
    @type_id = creature_type.id.to_i
    @max_health = creature_type.starting_health.to_i
    @attack = creature_type.starting_attack.to_i
    @defence = creature_type.starting_defence.to_i
    @speed = creature_type.starting_speed.to_i
    self.adjust_stats_by_level
    @current_health = details['current_health'] ? details['current_health'].to_i : @max_health
  end

  def get_creature_type()
    sql = "SELECT * FROM creature_types
    WHERE $1 = name;"
    values = [@type]
    return CreatureType.map_items(sql, values)[0]
  end

  def level_up
    @level += 1
    @max_health += 5
    @attack += 2
    @defence += 2
    @speed += 3
  end

  def adjust_stats_by_level
    levels_to_adjust = (@level - 1)
    counter = 0

    while counter < levels_to_adjust do
      self.level_up
      @level -= 1
      @exp += 10
      counter += 1
    end
  end

  def check_null(id)
    if id == "None"
      return nil
    elsif id.to_i > 0
      return id.to_i
    end
  end

  def save()
    sql = "INSERT INTO creatures
    (name, capture_date, fightable, type, level, exp, type_id, max_health, current_health, attack, defence, speed, gladiator_id)
    VALUES 
    ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)
    RETURNING id;"
    values = [@name, @capture_date, @fightable, @type, @level, @exp, @type_id, @max_health, @current_health, @attack, @defence, @speed, @gladiator_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql1 = "UPDATE creatures
    SET 
    name = $1, 
    capture_date = $2, 
    fightable = $3,
    type = $4,
    level = $5,
    exp = $6,
    type_id = $7,
    max_health = $8,
    current_health = $9,
    attack = $10,
    defence = $11,
    speed = $12,
    gladiator_id = $13
    WHERE id = $14;"
    values1 = [@name, @capture_date, @fightable, @type, @level, @exp, @type_id, @max_health, @current_health, @attack, @defence, @speed, @gladiator_id, @id]
    SqlRunner.run(sql1, values1)
  end

  def delete()
    sql = "DELETE FROM creatures
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def fight_ready()
    if @fightable
      return "Ready for action"
    elsif @fightable == false
      return "Not ready yet"
    end
  end

  def gladiators()
    sql = "SELECT * FROM gladiators
    WHERE $1 = gladiators.id;"
    values = [@gladiator_id]
    if @gladiator_id != nil || @gladiator_id != 0
      return Gladiator.map_items(sql, values)
    end
  end

  def gladiator_names()
    gladiators = self.gladiators
    if gladiators != nil
      names = 'Not fighting anyone'
      gladiators.each { |gladiator| names = "#{gladiator.name}"}
      return names
    else
      return "Not fighting anyone"
    end
  end

  def self.all()
    sql = "SELECT * FROM creatures;"
    values = nil
    self.map_items(sql, values)
  end

  def self.map_items(sql, values)
    creatures_hash = SqlRunner.run(sql, values)
    result = creatures_hash.map { |creature| Creature.new(creature)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM creatures"
    values = nil
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM creatures
    WHERE id = $1"
    values = [id]
    creature = self.map_items(sql, values)[0]
    return creature
  end

  def self.all_types
    creatures = self.all
    types = creatures.map { |creature| creature.type}
    return types.uniq
  end

  def self.all_levels
    creatures = self.all
    creature_levels = creatures.map { |creature| creature.level}
    return creature_levels.uniq
  end

  def self.get_type(type)
    if type == "Creature"
      sql = "SELECT * FROM creatures;"
      values = nil
      creatures = self.map_items(sql, values)
      return creatures
    else
      sql = "SELECT * FROM creatures
      WHERE type = $1;"
      values = [type]
      creatures = self.map_items(sql, values)
      return creatures
    end
  end

  def self.get_fightable(ready)
      sql = "SELECT * FROM creatures
      WHERE fightable = $1;"
      values = [ready]
      creatures = self.map_items(sql, values)
      return creatures
  end

  def self.get_level(level)
    if level == 0
      sql = "SELECT * FROM creatures;"
      values = nil
      creatures = self.map_items(sql, values)
      return creatures
    else
      sql = "SELECT * FROM creatures
      WHERE level = $1;"
      values = [level]
      creatures = self.map_items(sql, values)
      return creatures
    end
  end

  # def self.filter_find(type, ready)
  #   if type == nil && ready == nil
  #     self.all
  #   elsif ready == nil
  #     self.get_type(type)
  #   elsif ((type == "Creature" && ready == 't') || (type == "Creature" && ready == 'f'))
  #    self.get_fightable(ready)
  #   elsif ready == 't' || ready == 'f'
  #     sql = "SELECT * FROM creatures
  #     WHERE type = $1 AND fightable = $2;"
  #     values = [type, ready]
  #     creatures = self.map_items(sql, values)
  #     return creatures
  #   end
  # end

  def self.filter_find(type, ready, level)
    level = level.to_i
    if type == nil && ready == nil && level == 0
      self.all
    elsif ready == nil && level == 0
      self.get_type(type)
    elsif ((type == "Creature" && ready == 't' && level == 0) || (type == "Creature" && ready == 'f'  && level == 0))
     self.get_fightable(ready)
    elsif ((type != "Creature" && level == 0 && ready == 't') || (type != "Creature" && ready == 'f' && level == 0))
      sql = "SELECT * FROM creatures
      WHERE type = $1 AND fightable = $2;"
      values = [type, ready]
      creatures = self.map_items(sql, values)
   elsif (type == "Creature" && level != 0 && ready == nil)
      self.get_level(level)
    elsif (type != "Creature" && level != 0 && ready == nil)
      sql = "SELECT * FROM creatures
      WHERE type = $1 AND level = $2;"
      values = [type, level]
      creatures = self.map_items(sql, values)
      return creatures
    elsif (type == "Creature" && level != 0 && ready != nil)
      sql = "SELECT * FROM creatures
      WHERE fightable = $1 AND level = $2;"
      values = [ready, level]
      creatures = self.map_items(sql, values)
      return creatures
    elsif (type != "Creature" && level != 0 && ready != nil)
      sql = "SELECT * FROM creatures
      WHERE type = $1 AND fightable = $2 AND level = $3;"
      values = [type, ready, level]
      creatures = self.map_items(sql, values)
      return creatures
    end
  end

end