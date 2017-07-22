require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/creature.rb' )
require_relative( '../models/gladiator.rb' )

also_reload( '../models/*.rb') if development?

get '/gladiators' do
  @gladiators = Gladiator.all
  erb(:"gladiators/index")
end

get '/gladiators/new' do
  erb(:"gladiators/new")
end

post '/gladiators' do
  gladiator1 = Gladiator.new(params)
  gladiator1.save
  redirect '/gladiators'
end

# get '/fighter/new' do
#   @creatures = Creature.all
#   @fighters = Fighter.all
#   erb(:index)
# end

# post '/fighter' do
#   @creatures = Creature.all
#   @fighters = Fighter.all
#   erb(:index)
# end