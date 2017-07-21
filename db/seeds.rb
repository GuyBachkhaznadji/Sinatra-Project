require_relative('../models/creature.rb')
require_relative('../models/fighter.rb')

Creature.delete_all
Fighter.delete_all

fighter1 = Fighter.new({'name' => "Tiberius Maximus"})
fighter1.save

fighter2 = Fighter.new({'name' => "Atlas Nero"})
fighter2.save

creature1 = Creature.new({'name' => "Nembit, The Firestarter", 'capture_date' => "5/5/0100", 'fightable' => 't', 'fighter_id' => fighter1.id})
creature1.save

creature1 = Creature.new({'name' => "Smaug, The Terrible", 'capture_date' => "15/10/0500", 'fightable' => 'f', 'fighter_id' => fighter2.id})
creature1.save

creature1.name = 'hello'
creature1.update
p creature1