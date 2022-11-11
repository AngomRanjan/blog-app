class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comments_counter
  before_destroy :update_comments_counter_on_destroy

  def update_comments_counter
    post.increment!(:comments_counter)
  end

  def update_comments_counter_on_destroy
    post.update_columns('comments_counter' => post.comments_counter - 1)
  end
end
