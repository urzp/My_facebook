class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "150x150#", thumb: "80x80#" },
                                  :default_url => "/images/default_image.png"


  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
