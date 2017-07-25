require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/creature.rb' )
require_relative( '../models/gladiator.rb' )
require_relative( '../models/fight.rb' )

also_reload( '../models/*.rb') if development?

#INDEX / SHOW ALL
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
  @gladiator = Gladiator.find(@id.to_i)
  erb(:"gladiators/edit")
end

#UPDATE
post '/gladiators/:id' do
  gladiator = Gladiator.new(params)
  gladiator.update
  redirect '/gladiators'
end

#GET DESTROY
get '/gladiators/:id/destroy' do
  @id = params['id']
  erb(:"gladiators/destroy")
end

#DESTROY
post '/gladiators/:id/destroy' do
  gladiator = Gladiator.find(params[:id])
  gladiator.delete
  redirect '/gladiators'
end


#FIGHT
get '/gladiators/:id/fight' do
  @gladiator = Gladiator.find(params[:id])
  @fight = Fight.new({'gladiator' => @gladiator, 'creature' => @gladiator.creature})
  @round = @fight.round
  erb(:"gladiators/fight")
end