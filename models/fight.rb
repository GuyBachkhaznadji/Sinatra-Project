require_relative('../db/sql_runner.rb')
require_relative('./creature.rb')
require_relative('./gladiator.rb')

class Fight

  attr_reader()

  def initialize(details)
    @id = details['id'].to_i if details['id'].to_i
    @creature = details['creature']
    @gladiator = details['gladiator']
  end

  def first()
    if @creature.speed > @gladiator.speed
      return @creature
    elsif @gladiator.speed > @creature.speed
      return @gladiator
    elsif @creature.speed == @gladiator.speed
      fighters = [@creature, @gladiator]
      return fighters.sample
    end
  end

end