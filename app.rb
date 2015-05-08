require('sinatra')
require('sinatra/reloader')
require('./lib/client')
require('./lib/stylist')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

get('/stylist_form') do
  erb(:stylist_form)
end

post('/') do
  name = params.fetch('name')
  stylist = Stylist.new({:name => name, :id => nil})
  stylist.save()
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

get('/client_form') do
  erb(:client_form)
end

post('/add_client') do
  client_name = params.fetch('client_name')
  client = Client.new({:name => client_name, :id => nil, :stylist_id => nil})
  client.save()
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:index)
end

get('/stylist/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @clients = Client.all()
  erb(:stylist)
end

get('/client/:id') do
  @client = Client.find(params.fetch("id").to_i())
  @stylists = Stylist.all()
  erb(:client)
end

patch('/connection') do
  @stylist = Stylist.find(params.fetch("stylist_id"))
  stylist_id = @stylist.id().to_i()
  @client = Client.find(params.fetch("client_id").to_i())
  @client.update({:stylist_id => stylist_id})
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

# patch('/client/client/:id') do
#   client_id = params.fetch("id").to_i()
#   @client = Client.find(client_id)
#   stylist_id = params.fetch("stylist_id")
#   stylist = Stylist.find(stylist_id)
#   name = stylist.name()
#   @client.add_stylist(name)
#   @clients = Client.all()
#   @stylists = Stylist.all()
#   erb(:index)
# end
