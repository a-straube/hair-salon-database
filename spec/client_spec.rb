require('spec_helper')

describe(Client) do

  describe('#name') do
    it("returns the name of a client") do
      client = Client.new({:name => "Lisa Smith", :id => nil, :stylist_id => nil})
      expect(client.name()).to(eq("Lisa Smith"))
    end
  end

  describe('.all') do
    it("returns all of the clients in the database") do
      client1 = Client.new({:name => "Valeri Jones", :id => nil, :stylist_id => nil})
      client1.save()
      client2 = Client.new({:name => "Abigail Lastname", :id => nil, :stylist_id => nil})
      client2.save()
      expect(Client.all()).to(eq([client1, client2]))
    end
  end

  describe('#add_stylist') do
    it("assigns a stylist to a client") do
      client = Client.new({:name => "Valeri Jones", :id => nil, :stylist_id => nil})
      client.save()
      stylist = Stylist.new({:name => "DD Arroyo", :id => nil})
      stylist.save()
      client.add_stylist("DD Arroyo")
      stylist_id = stylist.id()
      client_stylist_id = client.stylist_id()
      expect(stylist_id).to(eq(client_stylist_id))
    end
  end

  describe('.find') do
    it("finds a specific client from an id") do
      client1 = Client.new({:name => "Barbara Johnson", :id => nil, :stylist_id => nil})
      client1.save()
      client2 = Client.new({:name => "Jo Smith", :id => nil, :stylist_id => nil})
      client2.save()
      expect(Client.find(client2.id())).to(eq(client2))
    end
  end

end
