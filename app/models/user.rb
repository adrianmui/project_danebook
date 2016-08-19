class User < ApplicationRecord
  has_secure_password

  validates :username, length: { :minimum => 1}, uniqueness: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /@.*[.]com\z/

  # validates :password, length: { in: (5..26) }, :allow_nil => false
  before_create :generate_token

  has_one :profile, class_name: "Profile"
  has_many :posts, class_name: "Post"
  has_many :comments, class_name: "Comment"

  has_many :likes, :as => :likeable, class_name: "Liking"
  has_many :photos, :as => :photoable, class_name: "Photo"

  #generates and regenerates tokens and sets to self
  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def already_likes?
    self.likes.empty? ? false : true
  end

  # will_be_implemented
  # def has_photo?  
  #   self.photo.nil? ? false : true
  # end
end
