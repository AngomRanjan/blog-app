require 'rails_helper'

RSpec.describe 'Test Index Page', type: :feature do
  describe 'GET index' do
    before(:each) do
      @first_user = User.create(name: 'Ranj', photo: 'ranj.png', bio: 'bio1', posts_counter: 4)
      @first_user.save!
      @second_user = User.create(name: 'Tamneo', photo: 'tamneo.png', bio: 'bio2', posts_counter: 5)
      @second_user.save!
      @third_user = User.create(name: 'Abemma', photo: 'abemma.png', bio: 'bio3', posts_counter: 2)
      @third_user.save!
    end

    it 'shows the users username' do
      visit root_path
      expect(page).to have_content('Ranj')
      expect(page).to have_content('Tamneo')
      expect(page).to have_content('Abemma')
    end

    it 'shows the users profile picture' do
      visit root_path
      expect(page).to have_css('img[src*="ranj.png"]')
      expect(page).to have_css('img[src*="tamneo.png"]')
      expect(page).to have_css('img[src*="abemma.png"]')
    end

    it 'shows the number of posts of each user' do
      visit root_path
      expect(page).to have_content('4')
      expect(page).to have_content('5')
      expect(page).to have_content('2')
    end
  end
end
