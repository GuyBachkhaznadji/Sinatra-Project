require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/creature.rb' )
require_relative( '../models/gladiator.rb' )

also_reload( '../models/*.rb') if development?

#INDEX / SHOW ALL
get '/creatures' do
  @creatures = Creature.all
  erb(:"creatures/index")
end

get '/creatures/ready' do
  @creatures = Creature.all  
  erb(:"creatures/ready")
end

get '/creatures/not-ready' do
  @creatures = Creature.all
  erb(:"creatures/not_ready")
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
  @gladiators = Gladiator.all
  erb(:"creatures/edit")
end

#EDIT
get '/creatures/ready/:id/edit' do
  @id = params['id']
  @gladiators = Gladiator.all
  erb(:"creatures/ready_edit")
end

#EDIT
get '/creatures/not-ready/:id/edit' do
  @id = params['id']
  @gladiators = Gladiator.all
  erb(:"creatures/not_ready_edit")
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