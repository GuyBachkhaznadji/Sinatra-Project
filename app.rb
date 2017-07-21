require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( './models/creature.rb' )
require_relative( './models/fighter.rb' )

also_reload( './models/*.rb') if development?


get '/' do
  @creatures = Creature.all
  @fighters = Fighter.all
  erb(:index)
end