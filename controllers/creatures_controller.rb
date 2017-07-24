require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/creature.rb' )
require_relative( '../models/gladiator.rb' )
require('pry')

also_reload( '../models/*.rb') if development?

#INDEX / SHOW ALL
get '/creatures' do
  @types = Creature.all_types 
  @type = params['type']
  @ready = params['ready']
  @creatures = Creature.filter_find(@type, @ready)
  erb(:"creatures/index")
end

#NEW
get '/creatures/new' do
  @gladiators = Gladiator.all
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
  @types = Creature.types
  @creature = Creature.find(@id.to_i)
  @gladiators = Gladiator.all
  erb(:"creatures/edit")
end

#UPDATE
post '/creatures/:id' do
  creature = Creature.new(params)
  creature.update
  redirect '/creatures'
end

#GET DESTROY
get '/creatures/:id/destroy' do
  @id = params['id']
  erb(:"creatures/destroy")
end

#DESTROY
post '/creatures/:id/destroy' do
  creature = Creature.find(params['id'])
  creature.delete
  redirect '/creatures'
end