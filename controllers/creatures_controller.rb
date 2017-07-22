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

#NEW
get '/creatures/new' do
  erb(:"creatures/new")
end

#CREATE
post '/creatures' do
  creature = Creature.new(params)
  creature.save
  redirect '/creatures'
end

#EDIT
get '/creatures/:id/edit' do
  @id = params['id']
  @gladiators = Gladiator.all
  erb(:"creatures/edit")
end

#UPDATE
post '/creatures/:id' do
  creature = Creature.new(params)
  creature.update
  redirect '/creatures'
end