require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Angom', photo: 'https://angom.com/me.png',
      bio: 'Full Stack Developer from India', posts_counter: 0
    )
  end

  before { subject.save }

  context 'Return valid data' do
    it 'should accept name' do
      subject.name = 'Angom'
      expect(subject).to be_valid
    end

    it 'should accept posts_counter' do
      subject.posts_counter = 3
      expect(subject).to be_valid
    end
  end

  context 'Return invalid data' do
    it 'should not accept blank name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should not accept negative posts_counter' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should not accept non numerical posts_counter' do
      subject.posts_counter = 'count'
      expect(subject).to_not be_valid
    end
  end
end
