class Post < ActiveRecord::Base

	belongs_to :user
	
	validates_presence_of :title, :body#, :user_id
	validates :title, length: { minimum: 5, maximum: 100 }
	validates :title, uniqueness: true
end
