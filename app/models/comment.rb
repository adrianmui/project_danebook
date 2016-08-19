class Comment < ApplicationRecord
  validates :description, presence: true
  belongs_to :profile, class_name: "Profile"

  belongs_to :user, class_name: "User"
end