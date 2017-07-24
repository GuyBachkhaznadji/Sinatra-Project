require_relative('../db/sql_runner.rb')

class Creature

  attr_accessor(:gladiator_id, :name, :capture_date, :fightable, :type)
  attr_reader(:id)

  def initialize(details)
    true_false = {'t' => true, 'f' => false}
    @id = details['id'].to_i if details['id'].to_i
    @name = details['name']
    @type = details['type']
    @capture_date = details['capture_date']
    @fightable = true_false[details['fightable']]
    @gladiator_id = details['gladiator_id'].to_i
  end

  def save()
    sql = "INSERT INTO creatures
    (name, capture_date, fightable, type)
    VALUES 
    ($1, $2, $3, $4)
    RETURNING id;"
    values = [@name, @capture_date, @fightable, @type]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql1 = "UPDATE creatures
    SET 
    name = $1, 
    capture_date = $2, 
    fightable = $3,
    type = $4
    WHERE id = $5;"
    values1 = [@name, @capture_date, @fightable, @type, @id]
    SqlRunner.run(sql1, values1)
    
    sql2 = "UPDATE creatures
    SET gladiator_id = $2
    WHERE id = $1 AND $2 != 0"
    values2 = [@id, @gladiator_id]
    SqlRunner.run(sql2, values2)
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
    return types.uniq!
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

  def self.filter_find(type, ready)
    if type == nil && ready == nil
      self.all
    elsif ready == nil
      self.get_type(type)
    elsif ((type == "Creature" && ready == 't') || (type == "Creature" && ready == 'f'))
      sql = "SELECT * FROM creatures
      WHERE fightable = $1;"
      values = [ready]
      creatures = self.map_items(sql, values)
      return creatures
    elsif ready == 't' || ready == 'f'
      sql = "SELECT * FROM creatures
      WHERE type = $1 AND fightable = $2;"
      values = [type, ready]
      creatures = self.map_items(sql, values)
      return creatures
    end
  end

end