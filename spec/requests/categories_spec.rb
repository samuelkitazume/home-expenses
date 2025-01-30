require 'swagger_helper'

RSpec.describe 'Categories API', type: :request do

  path '/categories' do
    get 'Retrieves all categories' do
      tags 'Categories'
      produces 'application/json'
      
      response '200', 'categories found' do
        run_test!
      end
    end

    post 'Creates a category' do
      tags 'Categories'
      consumes 'application/json'
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response '201', 'category created' do
        let(:category) { { name: 'Groceries' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:category) { { name: '' } } # Invalid request with empty name
        run_test!
      end
    end
  end

  path '/categories/{id}' do
    parameter name: :id, in: :path, type: :integer, required: true, description: 'ID of the category'

    get 'Retrieves a specific category' do
      tags 'Categories'
      produces 'application/json'

      response '200', 'category found' do
        let(:id) { Category.create(name: 'Utilities').id }
        run_test!
      end

      response '404', 'category not found' do
        let(:id) { 999 } # Non-existing ID
        run_test!
      end
    end

    patch 'Updates a category' do
      tags 'Categories'
      consumes 'application/json'
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        }
      }

      response '200', 'category updated' do
        let(:id) { Category.create(name: 'Old Category').id }
        let(:category) { { name: 'Updated Category' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { Category.create(name: 'Old Category').id }
        let(:category) { { name: '' } } # Invalid request
        run_test!
      end

      response '404', 'category not found' do
        let(:id) { 999 }
        let(:category) { { name: 'Updated Category' } }
        run_test!
      end
    end

    delete 'Deletes a category' do
      tags 'Categories'

      response '204', 'category deleted' do
        let(:id) { Category.create(name: 'To Be Deleted').id }
        run_test!
      end

      response '404', 'category not found' do
        let(:id) { 999 }
        run_test!
      end
    end
  end
end