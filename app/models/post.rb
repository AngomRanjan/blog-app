class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, class_name: 'Comment', foreign_key: 'post_id'
  has_many :likes, class_name: 'Like', foreign_key: 'post_id'

  after_save :update_posts_counter

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def recent_comments
    comments.last(5)
  end
end
