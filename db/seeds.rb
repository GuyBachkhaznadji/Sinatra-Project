require_relative('../models/creature.rb')
require_relative('../models/fighter.rb')

fighter1 = Fighter.new({'name' => "Tiberius Maximus"})
fighter1.save

fighter2 = Fighter.new({'name' => "Atlas Nero"})
fighter2.save

creature1 = Creature.new({'name' => "Nembit, The Firestarter", 'caputure_date' => "5/5/0100", 'fightable' => true, 'fighter_id' => fighter1.id})
creature1.save

creature1.fighter_id = fighter2.id
creature1.update