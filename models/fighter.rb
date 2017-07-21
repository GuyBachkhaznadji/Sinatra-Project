require_relative('../db/sql_runner.rb')

class Fighter

  attr_accessor(:name)
  attr_reader(:id)

  def initialize(details)
    @id = details['id'].to_i
    @name = details['name']
  end

  def save
    sql = "INSERT INTO fighters
    (name)
    VALUES 
    ($1)
    RETURNING id;"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM fighters;"
    values = nil
    self.map_items(sql, values)
  end

  def self.map_items(sql, values)
    fighters_hash = SqlRunner.run(sql, values)
    result = fighters_hash.map { |fighter| Fighter.new(fighter)}
    return result
  end

  def self.delete_all
    sql = 'DELETE FROM fighters'
    values = nil
    SqlRunner.run(sql, values)
  end

end