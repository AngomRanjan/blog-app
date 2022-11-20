require 'swagger_helper'

describe 'Posts API' do
  scenario 'valid with correct credentials' do
    path '/api/v1/users/1/posts.json' do
      get 'Retrieves a Posts' do
        tags 'Posts'
        produces 'application/json'
        consumes 'application/json'
        security [basic_auth: []]
        parameter name: :user_id, in: :path, type: :string

        response '200', 'post found' do
          let(:Authorization) do
            valid_basic_auth_token
          end
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   comments_counter: { type: :integer },
                   likes_counter: { type: :integer },
                   author_id: { type: :integer }
                 },
                 required: %w[id title text comments_counter likes_counter author]
          run_test!
        end
      end
    end
  end
end
