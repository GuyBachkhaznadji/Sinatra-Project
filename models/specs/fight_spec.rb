require('minitest/autorun')
require_relative('../creature_type.rb')
require_relative('../creature.rb')
require_relative('../gladiator.rb')
require_relative('../fight.rb')


class TestFight < MiniTest::Test

  def setup
    @creature_type1 = CreatureType.new({'name' => "Dragon", "starting_health" => 30, "starting_attack" => 3, "starting_defence" => 3, "starting_speed" => 5 })
    @creature_type1.save

    @creature_type2 = CreatureType.new({'name' => "Gladiator", "starting_health" => 7, "starting_attack" => 2, "starting_defence" => 1, "starting_speed" => 2 })
    @creature_type2.save

    @gladiator1 = Gladiator.new({'name' => "Tiberius Maximus", 'level' => 1, "exp" => 0})
    @gladiator1.save

    @creature1 = Creature.new({'name' => "Nembit, The Firestarter", 'type' => "Dragon", 'capture_date' => "5/5/0100", 'fightable' => 't', 'gladiator_id' => @gladiator1.id, 'level' => 1, "exp" => 0})
    @creature1.save

    @fight1 = Fight.new({'creature' => @creature1, 'gladiator' => @gladiator1})
  end

  def test_attack_order
    fighter = @fight1.attack_order
    assert_equal([@fight1.creature, @fight1.gladiator], fighter)
  end

  # def test_last
  #   fighter = @fight1.last
  #   assert_equal(@gladiator1, fighter)
  # end

  def test_anyone_dead?
    @fight1.creature.current_health = 0
    fight = @fight1.anyone_dead?
    assert_equal(true, fight)
  end

  def test_get_dead
    @fight1.creature.current_health = 0
    dead_fighter = @fight1.get_dead
    assert_equal(@creature1, dead_fighter)
  end

  def test_win?
    @fight1.creature.current_health = 0
    fight = @fight1.win?
    assert_equal(true, fight)
  end

  def test_exp_up
    @fight1.exp_up
    assert_equal(5, @gladiator1.exp)
  end

  def test_can_level_up?
    @fight1.gladiator.exp = 10
    assert_equal(true, @fight1.can_level_up?)
  end

  def test_level_up
    @fight1.level_up
    # @gladiator1.level_up
    assert_equal(2, @fight1.gladiator.level)
    assert_equal(12, @fight1.gladiator.max_health)
    assert_equal(7, @fight1.gladiator.attack)
    assert_equal(3, @fight1.gladiator.defence)
    assert_equal(5, @fight1.gladiator.speed)
  end

  # def test_attack
    
  # end

end

