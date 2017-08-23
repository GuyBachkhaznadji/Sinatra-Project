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

  def anyone_dead?()
    if @creature.current_health <= 0 || @gladiator.current_health <= 0
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
    if  @creature.current_health <= 0
      return true
    elsif @gladiator.current_health <= 0
      return false
    end
  end

  def exp_up
    @gladiator.exp += 5
  end

  def can_level_up?
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

  def attack_phase(attacker, attacked)
    miss_chance = [1,1,1,1,0].sample
    damage_chance = [-1,0,1].sample
    crit_chance = [1,1,1,1,2].sample

    attacker.attack *= miss_chance
    attacker.attack += damage_chance
    attacker.attack *= crit_chance

    if attacker.attack == 0
      return "missed"
    elsif attacker.attack > attacked.defence
      damage = (attacker.attack - attacked.defence)
    else
      damage = 1
    end

    def It_should_damage_the_defender_with_an_attack(attacker, attacked)
    # It should have a 1 in 5 chance of missing
    # It should have a 1 in 6 chance of doing double damage
     end
  
    attacked.current_health -= damage
    return "did #{damage} damage"
  end

  def update_dead_creature(attacker, attacked)
    if attacker.class == Creature
      attacker.fightable = false
      attacker.gladiator_id = nil
      attacker.update
    else 
      attacked.fightable = false
      attacked.gladiator_id = nil
      attacked.update
    end
  end

  def update_gladiator(attacker, attacked)
    if attacker.class == Gladiator
      attacker.update
    else 
      attacked.update
    end
  end

  def delete_gladiator(attacker, attacked)
    if attacker.class == Gladiator
      attacker.delete
    else 
      attacked.update
    end
  end

  def half_round(attacker, attacked)
    damage_message = attack_phase(attacker, attacked)
    screen_message = ""

    if win?
      screen_message += "#{@gladiator.name} #{damage_message}! <br>"
      screen_message += "Well done, you have slain #{@creature.name}!<br> "
      self.exp_up
      @creature.fightable = false
      @creature.gladiator_id = nil
      @creature.update      
      if self.can_level_up?
        @gladiator.level_up
        @gladiator.update
        return screen_message += "You levelled up and are now #{@gladiator.level}!<br> "
      end

      @gladiator.update
      return screen_message += "I'd recommend getting some rest now.<br>"
    elsif anyone_dead?
     screen_message += "#{@gladiator.name} has died!<br>"
     @gladiator.delete
     return screen_message += "Better luck next time<br>" 
    end

    if !anyone_dead?
      attacker.update
      attacked.update
       return screen_message += "#{attacker.name} #{damage_message}! <br>"
    end
    return screen_message
  end


  def round
    decided_attack_order = self.attack_order
    first_attacker = decided_attack_order[0]
    second_attacker = decided_attack_order[1]
    screen_message = ""

    screen_message += self.half_round(first_attacker, second_attacker)

    if screen_message.include?("slain") || screen_message.include?("died")
      return screen_message
    end
    screen_message += self.half_round(second_attacker, first_attacker)
    return screen_message
  end

end