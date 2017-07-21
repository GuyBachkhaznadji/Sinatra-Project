require_relative('../models/creature.rb')
require_relative('../models/fighter.rb')


creature1 = Creature.new({'name' => "Nembit, The Firestarter", 'caputure_date' => "5/5/0100", 'fightable' => true})
creature1.save

fighter1 = Fighter.new({'name' => "Tiberius Maximus"})
fighter1.save