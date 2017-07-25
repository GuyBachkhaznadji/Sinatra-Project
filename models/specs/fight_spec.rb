require('minitest/autorun')
require_relative('../fight.rb')


class TestFight < MiniTest::Test

  def setup
    creature_type1 = CreatureType.new({'name' => "Dragon", "starting_health" => 30, "starting_attack" => 3, "starting_defence" => 3, "starting_speed" => 5 })
    creature_type1.save
    creature1 = Creature.new({'name' => "Nembit, The Firestarter", 'type' => "Dragon", 'capture_date' => "5/5/0100", 'fightable' => 't', 'gladiator_id' => gladiator1.id, 'level' => 1, "exp" => 0})
    creature1.save
    creature1.update
  end


end