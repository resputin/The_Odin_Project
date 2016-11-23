class User < ApplicationRecord
  before_create :set_remember_token
  attr_accessor :remember_token
  has_secure_password
  has_many :posts

  def set_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
    self.remember_digest = Digest::SHA1.hexdigest(remember_token.to_s)
  end
end
