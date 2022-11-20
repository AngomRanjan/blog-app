require 'swagger_helper'

RSpec.describe 'api/v1/posts', type: :request do

  before(:all) do
    @user = User.create(
      name: 'Angom', photo: 'https://angom.com/me.png',
      bio: 'Full Stack Developer from India', posts_counter: 0
    )
  end

  subject do
    Post.new(
      title: 'About', text: 'About me', comments_counter: 1,
      likes_counter: 0, author_id: @user.id
    )
  end

  before { subject.save }
  
  path '/api/v1/users/{user_id}/posts' do
    # You'll want to customize the parameter types...
    # parameter name: 'user_id', in: :path, type: :string, description: 'user_id'tags 'Posts'

    get('list posts') do
      tags 'Posts'
      produces 'application/json'
      consumes 'application/json'
      security [basic_auth: []]
      parameter name: :user_id, in: :path, type: :string
      response(401, 'Unauthorized') do
        let(:Authorization) do
          valid_basic_auth_token
        end
        let(:user_id) { '1' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
