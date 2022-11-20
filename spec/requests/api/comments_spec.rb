require 'swagger_helper'

RSpec.describe 'Comments API', type: :request do
  scenario 'valid with correct credentials' do
    path '/api/v1/users/1/posts/1/comments.json' do
      get 'Retrieves a Comments' do
        tags 'Comments'
        produces 'application/json'
        consumes 'application/json'
        security [basic_auth: []]
        parameter name: :user_id, in: :path, type: :string
        parameter name: :post_id, in: :path, type: :string

        response '200', 'comment found' do
          let(:Authorization) do
            valid_basic_auth_token
          end
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   text: { type: :string },
                   author_id: { type: :integer }
                 },
                 required: %w[id text author]
          run_test!
        end
      end
    end
  end

  scenario 'create comment with correct credentials' do
    path '/api/v1/users/1/posts/1/comments.json' do
      post 'Creates a Comment' do
        tags 'Comments'
        produces 'application/json'
        consumes 'application/json'
        security [basic_auth: []]
        parameter name: :user_id, in: :path, type: :string
        parameter name: :post_id, in: :path, type: :string
        parameter name: :comment, in: :body, schema: {
          type: :object,
          properties: {
            text: { type: :string }
          },
          required: %w[text]
        }

        response '201', 'comment created' do
          let(:Authorization) do
            valid_basic_auth_token
          end
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   text: { type: :string },
                   author_id: { type: :integer }
                 },
                 required: %w[id text author]
          run_test!
        end
      end
    end
  end
end
