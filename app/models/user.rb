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

end
