require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( './models/creature.rb' )
require_relative( './models/gladiator.rb' )
require_relative('controllers/creatures_controller')
require_relative('controllers/gladiators_controller')

also_reload( './models/*.rb') if development?

get '/' do
  erb(:index)
end


