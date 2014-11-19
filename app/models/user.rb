class User < ActiveRecord::Base

	has_secure_password
	has_many :posts, dependent: :destroy

	validates_presence_of :name, :email, presence: true
	validates :name, length: { maximum: 50 }
	validates :email, uniqueness: true
	validates :password_digest, presence: true


end
