require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/creature.rb' )
require_relative( '../models/fighter.rb' )

also_reload( '../models/*.rb') if development?

get '/fighters' do
  @fighters = Fighter.all
  erb(:"fighters/index")
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