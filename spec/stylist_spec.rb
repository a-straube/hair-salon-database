require('spec_helper')

describe(Stylist) do

  describe('#name') do
    it("returns the name of a stylist") do
      stylist = Stylist.new({:name => "Barbara Johnson", :id => nil})
      expect(stylist.name()).to(eq("Barbara Johnson"))
    end
  end

end
