class User < ActiveRecord::Base

	has_secure_password
	has_many :posts, dependent: :destroy

	validates_presence_of :name, :email
	validates :name, length: { maximum: 50 }
	validates :email, uniqueness: true


end
