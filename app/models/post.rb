class Post < ActiveRecord::Base

	belongs_to :user, :foreign_key => "user_id"
	
	validates_presence_of :title, :body#, :user_id
	validates :title, length: { minimum: 5, maximum: 100 }
	validates :title, uniqueness: true

	#validates :user_id, presence: true
end
