require 'swagger_helper'

RSpec.describe 'Items API', type: :request do

  path '/items' do
    get 'Retrieves all items' do
      tags 'Items'
      produces 'application/json'
      
      response '200', 'items found' do
        run_test!
      end
    end

    post 'Creates an item' do
      tags 'Items'
      consumes 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number, format: :float }
        },
        required: ['name', 'price']
      }

      response '201', 'item created' do
        let(:item) { { name: 'Laptop', price: 999.99 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:item) { { name: '', price: 0 } } # Invalid request with empty name
        run_test!
      end
    end
  end

  path '/items/{id}' do
    parameter name: :id, in: :path, type: :integer, required: true, description: 'ID of the item'

    get 'Retrieves a specific item' do
      tags 'Items'
      produces 'application/json'

      response '200', 'item found' do
        let(:id) { Item.create(name: 'Phone', price: 499.99).id }
        run_test!
      end

      response '404', 'item not found' do
        let(:id) { 999 } # Non-existing ID
        run_test!
      end
    end

    patch 'Updates an item' do
      tags 'Items'
      consumes 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number, format: :float }
        }
      }

      response '200', 'item updated' do
        let(:id) { Item.create(name: 'Old Item', price: 20.0).id }
        let(:item) { { name: 'Updated Item', price: 30.0 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { Item.create(name: 'Old Item', price: 20.0).id }
        let(:item) { { name: '', price: 0 } } # Invalid request
        run_test!
      end

      response '404', 'item not found' do
        let(:id) { 999 }
        let(:item) { { name: 'Updated Item', price: 30.0 } }
        run_test!
      end
    end

    delete 'Deletes an item' do
      tags 'Items'

      response '204', 'item deleted' do
        let(:id) { Item.create(name: 'To Be Deleted', price: 10.0).id }
        run_test!
      end

      response '404', 'item not found' do
        let(:id) { 999 }
        run_test!
      end
    end
  end
end