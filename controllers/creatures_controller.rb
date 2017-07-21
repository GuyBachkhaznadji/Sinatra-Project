require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/creature.rb' )
require_relative( '../models/fighter.rb' )

also_reload( '../models/*.rb') if development?

get '/creatures' do
  @creatures = Creature.all
  erb(:"creatures/index")
end

# edit
get '/creatures/:id/edit' do
  @id = params['id']
  erb(:"creatures/edit")
end

# #EDIT
# get '/pizzas/:id/edit' do
#   @id = params[:id]
#   erb(:pizza_edit)
# end

# #UPDATE
# post '/pizzas/:id' do
#   @pizza = Pizza.find(params[:id])
#   @pizza.update
#   redirect '/pizzas'
# end