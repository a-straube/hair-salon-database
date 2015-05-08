require('spec_helper')

describe(Stylist) do

  describe('#name') do
    it("returns the name of a stylist") do
      stylist = Stylist.new({:name => "Barbara Johnson", :id => nil})
      expect(stylist.name()).to(eq("Barbara Johnson"))
    end
  end

  describe('.all') do
    it("returns all of the stylists in the database") do
      stylist1 = Stylist.new({:name => "Barbara Johnson", :id => nil})
      stylist1.save()
      stylist2 = Stylist.new({:name => "Jo Smith", :id => nil})
      stylist2.save()
      expect(Stylist.all()).to(eq([stylist1, stylist2]))
    end
  end
end
