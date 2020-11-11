class Post < ApplicationRecord
	belongs_to :user
	validates :post, presence: true, length: { maximum: 200 }
	has_many :post_comments, dependent: :destroy
  	has_many :favorites, dependent: :destroy

  	def favorited_by?(user)
  		favorites.where(user_id: user.id).exists?
  	end

  	def Post.search(search, user_or_post)
	  if user_or_post == "2"
	     Post.where(['title LIKE ?', "%#{search}%"])
	  else
	     Post.all
  		end
	end
end
