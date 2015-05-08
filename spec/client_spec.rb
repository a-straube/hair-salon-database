require('spec_helper')

describe(Client) do

  describe('#name') do
    it("returns the name of a client") do
      client = Client.new({:name => "Lisa Smith", :id => nil})
      expect(client.name()).to(eq("Lisa Smith"))
    end
  end

  describe('.all') do
    it("returns all of the clients in the database") do
      client1 = Client.new({:name => "Valeri Jones", :id => nil})
      client1.save()
      client2 = Client.new({:name => "Abigail Lastname", :id => nil})
      client2.save()
      expect(Client.all()).to(eq([client1, client2]))
    end
  end
end
