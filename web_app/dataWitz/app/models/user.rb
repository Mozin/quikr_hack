class User < ActiveRecord::Base
	has_secure_password
	before_save :create_remember_token
	validates :name,:presence => true, :length => {:maximum => 50}
	VALID_EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,:presence => true, :format => {:with => VALID_EMAIL_REGEX},:uniqueness => {:case_sensitive =>false}
	has_many :ad

private
  	def create_remember_token
    	    self.remember_token = SecureRandom.hex
    	end
end
