require_relative('../db/sql_runner.rb')

class Gladiator

  attr_accessor(:name)
  attr_reader(:id)

  def initialize(details)
    @id = details['id'].to_i
    @name = details['name']
  end

  def save()
    sql = "INSERT INTO gladiators
    (name)
    VALUES 
    ($1)
    RETURNING id;"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE gladiators
    SET 
    name = $1, 
    WHERE id = $2;"
    values = [@name, @id]
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