require_relative('../db/sql_runner.rb')
require_relative('./creature.rb')
require_relative('./gladiator.rb')

class Fight

  attr_reader(:creature, :gladiator)

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

  def dead?()
    if @creature.current_health <= 0 ||  @gladiator.current_health <= 0
      return true
    else
      return false
    end
  end

  def win?
    if @gladiator.current_health <= 0
      return false
    elsif @creature.current_health <= 0
      return true
    end
  end

  def exp_up
    @gladiator.exp += 1
  end

  def level_up?
    if @gladiator.exp % 10 == 0
      return true
    else
      return false
    end
  end

end