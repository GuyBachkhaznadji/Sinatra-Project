require_relative('../models/creature.rb')
require_relative('../models/gladiator.rb')

Creature.delete_all
Gladiator.delete_all

gladiator1 = Gladiator.new({'name' => "Tiberius Maximus"})
gladiator1.save

gladiator2 = Gladiator.new({'name' => "Atlas Nero"})
gladiator2.save

creature1 = Creature.new({'name' => "Nembit, The Firestarter", 'type' => "Dragon", 'capture_date' => "5/5/0100", 'fightable' => 't', 'gladiator_id' => gladiator1.id})
creature1.save

creature2 = Creature.new({'name' => "Smaug, The Terrible", 'type' => "Dragon", 'capture_date' => "15/10/0500", 'fightable' => 'f', 'gladiator_id' => gladiator2.id})
creature2.save

creature3 = Creature.new({'name' => "Leo, The Loud", 'type' => "Lion", 'capture_date' => "15/10/0235", 'fightable' => 'f'})
creature3.save

creature4 = Creature.new({'name' => "Ursa, The Tall",'type' => "Bear", 'capture_date' => "15/10/0235", 'fightable' => 'f', 'gladiator_id' => gladiator2.id})
creature4.save

gladiator3 = Gladiator.new({'name' => "Anthony Digitius"})
gladiator3.save