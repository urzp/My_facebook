require 'rails_helper'


  describe "test rspec" do

    it "should return 4" do
        expect(2+2).to eq(4)
    end

    it "should return 3" do
        expect(2+1).to eq(3)
    end

    it "should return 2" do
        expect(2*1).to eq(2)
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
      user1 = User.create!(email: "user1@email.ru", password: "12345678")
      user2 = User.create!(email: "user2@email.ru", password: "12345678")
      user1.wish_frends << user2
      expect(user2.inv_frends).to eq([user1])
    end

  end

    describe "User #relationship?(user)" do
      before(:each) do
        @user1 = User.create!(email: "user1@email.ru", password: "12345678")
        @user2 = User.create!(email: "user2@email.ru", password: "12345678")
        @user3 = User.create!(email: "user3@email.ru", password: "12345678")
        @user4 = User.create!(email: "user4@email.ru", password: "12345678")
      end

      it "shoud return :wish" do
        @user1.wish_frends << @user2
        expect(@user1.relationship?(@user2)).to eq(:wish)
      end

      it "shoud return :invit" do
        @user1.wish_frends << @user2
        expect(@user2.relationship?(@user1)).to eq(:invit)
      end

      it "shoud return :frend" do
        @user1.wish_frends << @user2
        @user2.accept_inv(@user1)
        expect(@user1.relationship?(@user2)).to eq(:frend)
      end

      it "shoud return nil " do
        expect(@user1.relationship?(@user2)).to eq(nil)
      end

      it "shoud delete invitation and return nil " do
        @user1.wish_frends << @user2
        @user2.delete_inv(@user1)
        expect(@user1.relationship?(@user2)).to eq(nil)
      end

      it "shoud delete wish and return nil " do
        @user1.wish_frends << @user2
        @user1.delete_wish(@user2)
        expect(@user1.relationship?(@user2)).to eq(nil)
      end

      it "shoud take 3 wish and accep 1 frend and return 2 current wish " do
        @user1.wish_frends << [@user2, @user3, @user4]
        @user2.accept_inv(@user1)
        expect(@user1.current_wishes.count).to eq(2)
      end

      it "shoud get 3 inv and accep 1 frend and return 2 current inv " do
        @user1.wish_frends << @user2
        @user3.wish_frends << @user2
        @user4.wish_frends << @user2
        @user2.accept_inv(@user1)
        expect(@user2.current_invites.count).to eq(2)
      end

      it "shoud add likes" do
        post = Post.new(title: "test", content: "test")
        @user1.posts << post
        like = Like.new
        like.user = @user1
      end

    end
