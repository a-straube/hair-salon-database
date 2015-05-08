require('spec_helper')

describe(Client) do

  describe('#name') do
    it("returns the name of a client") do
      client = Client.new({:name => "Lisa Smith", :id => nil})
      expect(client.name()).to(eq("Lisa Smith"))
    end
  end

end
