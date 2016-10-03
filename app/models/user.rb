class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
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

  def accept_inv(user)
    relation = self.reverse_relationships.find_by(wish_id: user.id)
    relation.accepted = true
    relation.save
  end

  def delete_inv(user)
    self.inv_frends.delete(user.id)
  end

  def delete_wish(user)
    self.wish_frends.delete(user.id)
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

  def current_inventes
    inventes = "SELECT wish_id FROM relationships WHERE  inv_id = :user_id
            AND accepted = false"
    User.where("id IN (#{inventes})", user_id: self.id )
  end

end
