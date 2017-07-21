require_relative('../db/sql_runner.rb')

class Creature

  attr_reader(:id, :name, :fightable, :fighter_id)

  def initialize(details)
    @id = details['id'].to_i
    @name = details['name']
    @fightable = details['fightable']
    @fighter_id = details['fighter_id']
  end

end