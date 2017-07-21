require_relative('../models/creature.rb')
require_relative('../models/fighter.rb')


creature1 = Creature.new({'name' => "Nembit, The Firestarter", 'caputure_date' => "5/5/0100", 'fightable' => true, 'fighter_id' => 1})
creature1.save