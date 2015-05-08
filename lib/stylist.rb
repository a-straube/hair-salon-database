class Stylist
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_method(:==) do |stylist2|
    self.name().==(stylist2.name()).&(self.id().==(stylist2.id()))
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      name = stylist.fetch("name")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({:name => name, :id => id}))
    end
    stylists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    @id = id
    returned_stylist = DB.exec("SELECT * FROM stylists WHERE id = #{@id};")
    @name = returned_stylist.first().fetch("name")
    Stylist.new({:name => @name, :id => @id})
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{self.id()};")
  end

  define_method(:clients) do
    clients = []
    results = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.(id)};")
    results.each do |result|
      name = result.fetch("name")
      client_id = result.fetch("id").to_i()
      clients.push(Client.new({:name => name, :id => client_id, :stylist_id => self.id()}))
    end
  end
end
