class Relationship < ActiveRecord::Base
  belongs_to :wish, class_name: "User"
  belongs_to :inv, class_name: "User"
end
