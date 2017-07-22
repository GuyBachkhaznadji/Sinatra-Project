require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/creature.rb' )
require_relative( '../models/gladiator.rb' )

also_reload( '../models/*.rb') if development?

#INDEX / SHOW
get '/gladiators' do
  @gladiators = Gladiator.all
  erb(:"gladiators/index")
end

#NEW
get '/gladiators/new' do
  erb(:"gladiators/new")
end

#CREATE
post '/gladiators' do
  gladiator = Gladiator.new(params)
  gladiator.save
  redirect '/gladiators'
end

#EDIT
get '/gladiators/:id/edit' do
  @id = params['id']
  @gladiators = Gladiator.all
  erb(:"gladiators/edit")
end

#UPDATE
post '/gladiators/:id' do
  gladiator = Gladiator.new(params)
  gladiator.update
  redirect '/gladiators'
end