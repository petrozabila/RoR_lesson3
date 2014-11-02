class Post < ActiveRecord::Base

	validates_presence_of :title, :body
	validates :title, length: { minimum: 5, maximum: 100 }
	validates :title, uniqueness: true
end
