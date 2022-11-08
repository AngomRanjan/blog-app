require 'rails_helper'

RSpec.describe 'posts#index', type: :feature do
  describe 'Post' do
    before(:each) do
      @user1 = User.create(name: 'Ranj', photo: 'Ranj.jpeg', bio: 'bio', posts_counter: 0)
      @user1.save!
      visit root_path

      @post1 = Post.create(title: 'First Post', text: 'This is my first post', comments_counter: 0, likes_counter: 3,
                           author: @user1)
      @post2 = Post.create(title: 'Second Post', text: 'This is my second post', comments_counter: 0, likes_counter: 0,
                           author: @user1)
      @post3 = Post.create(title: 'Third Post', text: 'This is my third post', comments_counter: 0, likes_counter: 0,
                           author: @user1)
      @comment1 = Comment.create(text: 'Comment first', author: User.first,
                                 post: @post1)
      @comment2 = Comment.create(text: 'Comment another', author: User.first, post: @post1)
      @comment3 = Comment.create(text: 'Comment new', author: User.first, post: @post1)
    end

    it "shows user's profile picture" do
      visit(user_posts_path(@user1.id))
      expect(page).to have_css('img[src*="Ranj.jpeg"]')
    end

    it 'shows the users username' do
      visit(user_posts_path(@user1.id))
      expect(page).to have_content('Ranj')
    end

    it 'shows number of posts of user has written' do
      visit(user_posts_path(@user1.id))
      expect(@user1.posts_counter).to eql(3)
    end

    it 'shows number of posts by user' do
      visit(user_posts_path(@user1.id))
      expect(page).to have_content('posts: 3')
    end

    it 'shows posts title' do
      visit(user_posts_path(@user1.id))
      expect(page).to have_content('Post : First Post')
    end

    it 'can see some of the post detail' do
      visit(user_posts_path(@user1.id))
      expect(page).to have_content 'This is my first post'
    end

    it 'can see the first comment on a post' do
      visit(user_posts_path(@user1.id))
      expect(page).to have_content 'Comment first'
    end

    it 'can see how many comments a post has.' do
      visit(user_posts_path(@user1.id))
      expect(page).to have_content('Comments: 3')
    end

    it 'can see how many likes a post has.' do
      visit(user_posts_path(@user1.id))
      expect(page).to have_content('Likes: 3')
    end

    it "redirects the user to the post's show page after clickin on it" do
      visit(user_posts_path(@user1.id))
      click_link 'First Post'
      expect(page).to have_current_path user_post_path(@post1.author_id, @post1)
    end
  end
end
