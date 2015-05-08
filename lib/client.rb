class Client
  attr_reader(:name, :id, :stylist_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @stylist_id = attributes.fetch(:stylist_id)
  end

  define_method(:==) do |client2|
    self.name().==(client2.name()).&(self.id().==(client2.id()))
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      name = client.fetch("name")
      id = client.fetch("id").to_i()
      clients.push(Client.new({:name => name, :id => id, :stylist_id => nil}))
    end
    clients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    @id = id
    returned_client = DB.exec("SELECT * FROM clients WHERE id = #{@id};")
    @name = returned_client.first().fetch("name")
    Client.new({:name => @name, :id => @id, :stylist_id => nil})
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{self.id()};")

    @stylist_id = attributes.fetch(:stylist_id, @stylist_id)
    DB.exec("UPDATE clients SET stylist_id = #{stylist_id} WHERE id = #{self.id};")
  end

end
