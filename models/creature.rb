require_relative('../db/sql_runner.rb')

class Creature

  attr_reader(:id, :name, :caputure_date, :fightable, :fighter_id)

  def initialize(details)
    @id = details['id'].to_i
    @name = details['name']
    @caputure_date = details['caputure_date']
    @fightable = details['fightable']
    @fighter_id = details['fighter_id']
  end

  def save
    sql = "INSERT INTO creatures
    (name, caputure_date, fightable, fighter_id)
    VALUES 
    ($1, $2, $3, $4 )
    RETURNING id;"
    values = [@name, @caputure_date, @fightable, @fighter_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM creatures;"
    values = nil
    self.map_items(sql, values)
  end

  def self.map_items(sql, values)
    creatures_hash = SqlRunner.run(sql, values)
    result = creatures_hash.map { |creature| Creature.new(creature)}
    return result
  end

end