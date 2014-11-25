class User < ActiveRecord::Base

	has_secure_password
	has_many :posts, dependent: :destroy
	has_many :comments

	validates_presence_of :name, :email, presence: true
	validates :name, length: { maximum: 50 }
	validates :email, uniqueness: true     #= validates_uniqueness_of :email
	validates :password_digest, presence: true

	def gravatar_url
	    downcased_email = email.strip.downcase
	    hash = Digest::MD5.hexdigest(downcased_email)
	    "http://gravatar.com/avatar/#{hash}"
    end

end
