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

  describe('.find') do
    it("finds a specific stylists from an id") do
      stylist1 = Stylist.new({:name => "Barbara Johnson", :id => nil})
      stylist1.save()
      stylist2 = Stylist.new({:name => "Jo Smith", :id => nil})
      stylist2.save()
      expect(Stylist.find(stylist2.id())).to(eq(stylist2))
    end
  end

  describe('#update') do
    it("updates the name of a stylistin the database") do
      stylist = Stylist.new({:name => "Sarah Smith", :id => nil})
      stylist.save()
      stylist.update({:name => "Sarah Igotmarried"})
      expect(stylist.name()).to(eq("Sarah Igotmarried"))
    end
  end
end
