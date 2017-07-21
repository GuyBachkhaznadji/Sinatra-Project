require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/creature.rb' )
require_relative( '../models/fighter.rb' )

also_reload( './models/*.rb') if development?


get '/creatures' do
  @creatures = Creature.all
  erb(:index)
end