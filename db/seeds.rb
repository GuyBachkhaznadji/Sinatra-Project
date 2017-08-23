require_relative('../models/creature.rb')
require_relative('../models/gladiator.rb')
require_relative('../models/creature_type.rb')

Creature.delete_all
Gladiator.delete_all
CreatureType.delete_all

creature_type1 = CreatureType.new({'name' => "Dragon", "starting_health" => 30, "starting_attack" => 9, "starting_defence" => 5, "starting_speed" => 5 })
creature_type1.save

creature_type2 = CreatureType.new({'name' => "Lion", "starting_health" => 20, "starting_attack" => 5, "starting_defence" => 2, "starting_speed" => 10 })
creature_type2.save

creature_type3 = CreatureType.new({'name' => "Bear", "starting_health" => 10, "starting_attack" => 2, "starting_defence" => 1, "starting_speed" => 3 })
creature_type3.save

creature_type4 = CreatureType.new({'name' => "Gladiator", "starting_health" => 7, "starting_attack" => 5, "starting_defence" => 2, "starting_speed" => 2 })
creature_type4.save

gladiator1 = Gladiator.new({'name' => "Tiberius Maximus", 'level' => 1, "exp" => 0})
gladiator1.save

gladiator2 = Gladiator.new({'name' => "Atlas Nero", 'level' => 2, "exp" => 0})
gladiator2.save

gladiator3 = Gladiator.new({'name' => "Anthony Digitius", 'level' => 3, "exp" => 0})
gladiator3.save

creature4 = Creature.new({'name' => "Ursa, The Tall",'type' => "Bear", 'capture_date' => "15/10/0235", 'fightable' => 't', 'level' => 1, "exp" => 0, 'gladiator_id' => gladiator1.id})
creature4.save

creature1 = Creature.new({'name' => "Nembit, The Firestarter", 'type' => "Dragon", 'capture_date' => "5/5/0100", 'fightable' => 't', 'level' => 1, "exp" => 0})
creature1.save

creature3 = Creature.new({'name' => "Leo, The Loud", 'type' => "Lion", 'capture_date' => "15/10/0235", 'fightable' => 'f', 'level' => 2, "exp" => 0})
creature3.save

creature2 = Creature.new({'name' => "Smaug, The Terrible", 'type' => "Dragon", 'capture_date' => "15/10/0500", 'fightable' => 'f', 'level' => 3, "exp" => 0})
creature2.save


# # p gladiator3.get_creature_type
# p gladiator3
# p creature4
# p Creature.all
# p Creature.all_types