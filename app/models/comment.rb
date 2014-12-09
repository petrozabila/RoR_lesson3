class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user

	has_many :composts

	has_ancestry

	validates_presence_of :post_id


	after_create :update_post
  def update_post
    self.post.touch
  end
end

