class Ad < ActiveRecord::Base
  belongs_to :user
  VALID_EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,:presence => true, :format => {:with => VALID_EMAIL_REGEX}
  validates :title,:presence => true, :length => {:maximum => 50 ,:minimum =>10}
  validates :userMobile,:presence => true	
end
