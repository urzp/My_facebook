require 'rails_helper'


  describe "test rspec" do

    it "should return 4" do
        expect(2+2).to eq(4)
    end

  end

  describe "User relationships" do

    it "shoud not exeption" do
      user1 = User.new
      expect(user1.wish_frends).to eq([])
    end

    it "shoud not exeption" do
      user = User.new
      expect(user.inv_frends).to eq([])
    end

    it "shoud return inv_frends" do
      user1 = User.new
      user2 = User.new
      user1.wish_frends << user2
      user1.save
      user2.save
      expect(user2.inv_frends).to eq([])
    end

  end
