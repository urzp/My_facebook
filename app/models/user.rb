class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  devise :omniauthable, :omniauth_providers => [:facebook]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "150x150#", thumb: '80x80>' },
                                  :default_url => "/images/default_image.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  has_many :wish_frends, through: :relationships, source: :inv
  has_many :relationships, foreign_key: "wish_id", dependent:			:destroy

  has_many :inv_frends, through:	:reverse_relationships,	source:	:wish
  has_many	:reverse_relationships,	foreign_key: "inv_id",
                      class_name: "Relationship",  dependent:			:destroy

  has_many :posts

  has_many :likes
  has_many :posts_likes, through: :likes, source: :post

  has_many :comments

  def accept_inv(user)
    relation = self.reverse_relationships.find_by(wish_id: user.id)
    relation.accepted = true
    relation.save
  end

  def seen_friend(user)
    relation = self.relationships.find_by(inv_id: user.id)
    relation.seen = true
    relation.save
  end

  def delete_inv(user)
    self.inv_frends.delete(user.id)
  end

  def delete_wish(user)
    self.wish_frends.delete(user.id)
  end

  def delete_realtionship(user)
    delete_wish(user) if self.wish_frends.any?{|u| u == user }
    delete_inv(user) if self.inv_frends.any?{|u| u == user }
  end

  def frends
    friendships = "SELECT wish_id FROM relationships WHERE inv_id = :user_id
						AND accepted = true"
    reverse_friendships = "SELECT inv_id FROM relationships WHERE wish_id = :user_id
        		AND accepted = true"
    User.where("id IN (#{friendships}) OR id IN (#{reverse_friendships})", user_id: self.id)
  end

  def current_wishes
    wishes = "SELECT inv_id FROM relationships WHERE wish_id = :user_id
            AND accepted = false"
    User.where("id IN (#{wishes})", user_id: self.id )
  end

  def current_invites
    inventes = "SELECT wish_id FROM relationships WHERE  inv_id = :user_id
            AND accepted = false"
    User.where("id IN (#{inventes})", user_id: self.id )
  end

  def new_friends
    reverse_friendships = "SELECT inv_id FROM relationships WHERE wish_id = :user_id
            AND accepted = true AND seen = false"
    User.where("id IN (#{reverse_friendships})", user_id: self.id)
  end

  def relationship?(user)
    return :wish if self.current_wishes.any?{|u| u == user }
    return :invit if self.current_invites.any?{|u| u == user }
    return :frend if self.frends.any?{|u| u == user }
    return nil
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
    end
  end



end
