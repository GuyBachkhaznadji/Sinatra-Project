require_relative('../db/sql_runner.rb')

class Creature

  attr_accessor(:gladiator_id, :name, :capture_date, :fightable)
  attr_reader(:id)

  def initialize(details)
    true_false = {'t' => true, 'f' => false}
    @id = details['id'].to_i if details['id'].to_i
    @name = details['name']
    @capture_date = details['capture_date']
    @fightable = true_false[details['fightable']]
    @gladiator_id = details['gladiator_id']
  end

  def save()
    sql = "INSERT INTO creatures
    (name, capture_date, fightable)
    VALUES 
    ($1, $2, $3)
    RETURNING id;"
    values = [@name, @capture_date, @fightable]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE creatures
    SET 
    name = $1, 
    capture_date = $2, 
    fightable = $3, 
    gladiator_id = $4
    WHERE id = $5;"
    values = [@name, @capture_date, @fightable, @gladiator_id, @id]
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
    if @gladiator_id != nil
      return Gladiator.map_items(sql, values)
    end
  end

  def gladiator_names
    gladiators = self.gladiators
    if gladiators != nil
      names = nil
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

end