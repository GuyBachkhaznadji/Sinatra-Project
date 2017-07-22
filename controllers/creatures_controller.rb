require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/creature.rb' )
require_relative( '../models/gladiator.rb' )

also_reload( '../models/*.rb') if development?

#INDEX / SHOW
get '/creatures' do
  @creatures = Creature.all
  erb(:"creatures/index")
end

#EDIT
get '/creatures/:id/edit' do
  @id = params['id']
  @gladiators = Gladiator.all
  erb(:"creatures/edit")
end

#UPDATE
post '/creatures/:id' do
  id = params['id'].to_i
  creature = Creature.find(id)
  creature.update
  redirect '/creatures'
end