require 'rails_helper'

RSpec.describe 'Post show', type: :feature do
  describe 'Post' do
    before(:each) do
      @user1 = User.create(name: 'Ranj', photo: 'Ranj.jpeg', bio: 'bio', posts_counter: 0)
      @user1.save!
      @user2 = User.create(name: 'Ron', photo: 'Ron.jpeg', bio: 'bio', posts_counter: 0)
      @user3 = User.create(name: 'Harry', photo: 'Harry', bio: 'bio', posts_counter: 0)
      @user4 = User.create(name: 'Sam', photo: 'Sam', bio: 'bio', posts_counter: 0)

      visit root_path

      @post1 = Post.create(title: 'First Post', text: 'This is my first post', comments_counter: 0, likes_counter: 3,
                           author: @user1)
      @post2 = Post.create(title: 'Second Post', text: 'This is my second post', comments_counter: 0, likes_counter: 0,
                           author: @user1)
      @post3 = Post.create(title: 'Third Post', text: 'This is my third post', comments_counter: 0, likes_counter: 0,
                           author: @user1)
      @comment1 = Comment.create(text: 'Comment first', author: @user2,
                                 post: @post1)
      @comment2 = Comment.create(text: 'Comment another', author: @user3, post: @post1)
      @comment3 = Comment.create(text: 'Comment new', author: @user4, post: @post1)

      visit user_post_path(@user1, @post1)
    end

    it 'shows posts title' do
      expect(page).to have_content('First Post')
    end

    it 'shows the person who wrote the post' do
      expect(page).to have_content('Ranj')
    end

    it 'shows number of comments' do
      expect(page).to have_content('Comments: 3')
    end

    it 'shows number of likes' do
      expect(page).to have_content('Likes: 3')
    end

    it 'can see the post\'s body.' do
      expect(page).to have_content('This is my first post')
    end

    it 'can see the username of each commentor.' do
      expect(page).to have_content 'Ron: '
      expect(page).to have_content 'Harry: '
      expect(page).to have_content 'Sam: '
    end

    it 'can see the comments of each commentor.' do
      expect(page).to have_content 'Ron: Comment first'
      expect(page).to have_content 'Harry: Comment another'
      expect(page).to have_content 'Sam: Comment new'
    end
  end
end
