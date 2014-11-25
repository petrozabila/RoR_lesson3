class Post < ActiveRecord::Base
	
	acts_as_votable
	
	belongs_to :user
	has_many :comments, dependent: :destroy

	
	
	validates_presence_of :title, :body
	validates :title, length: { minimum: 5, maximum: 140 }
	validates :title, uniqueness: true
	validates :body, length: { maximum: 140 }


	def score
  		self.get_upvotes.size - self.get_downvotes.size
  	end
	

	#validates :user_id, presence: true
end
