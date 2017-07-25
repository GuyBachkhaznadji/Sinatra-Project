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

  def attack_order()
    if @creature.speed > @gladiator.speed
      return [@creature, @gladiator]
    elsif @gladiator.speed > @creature.speed
      return [@gladiator, @creature]
    elsif @creature.speed == @gladiator.speed
      fighters = [@creature, @gladiator]
      return fighters.shuffle
    end
  end

  def dead?()
    if @creature.current_health <= 0 ||  @gladiator.current_health <= 0
      return true
    else
      return false
    end
  end

  def get_dead
    if @creature.current_health <= 0
      return @creature
    elsif @gladiator.current_health <= 0
      return @gladiator
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

  def level_up
    @gladiator.level += 1
    @gladiator.max_health += 5
    @gladiator.attack += 2
    @gladiator.defence += 2
    @gladiator.speed += 3
  end

  def attack(attacker, attackee)
    miss_chance = [1,1,1,1,0].sample
    damage_chance = [-1,0,1].sample
    crit_chance = [1,1,1,2].sample

    attacker.attack *= miss_chance
    attacker.attack += damage_chance
    attacker.attack *= crit_chance

    if attacker.attack == 0
      damage = 0
      return "You missed!"
    elsif attacker.attack > attackee.defence
      damage = (attacker.attack - attackee.defence)
    else
      damage = 1
    end
  
    attackee.current_health -= damage
  end

  def round
    first_attacker = self.attack_order[0]
    second_attacker = self.attack_order[1]
    attack(first_attacker, second_attacker)
    
    if dead? && win?
      puts "Well done! You have slain #{@creature.name}"
      self.exp_up
      if self.level_up?
        self.level_up
        return "You levelled up and are now #{@gladiator.level}!"
      end
      return "I'd recommend getting some rest now."
    elsif dead?
     puts "#{self.get_dead.name} has died!"
     return "Better luck next time"
    end
    
    attack(second_attacker, first_attacker)
    if dead? && win?
      puts "Well done! You have slain #{@creature.name}"
      self.exp_up
      if self.level_up?
        self.level_up
        return "You levelled up and are now #{@gladiator.level}!"
      end
      return "I'd recommend getting some rest now."
    elsif dead?
     puts "#{self.get_dead.name} has died!"
     return "Better luck next time"
    end
  end

end