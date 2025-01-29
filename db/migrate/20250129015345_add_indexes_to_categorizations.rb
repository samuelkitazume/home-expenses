class AddIndexesToCategorizations < ActiveRecord::Migration[8.0]
  def change
    # Check if the index for category_id exists before adding
    unless index_exists?(:categorizations, :category_id)
      add_index :categorizations, :category_id
    end

    # Check if the index for item_id exists before adding
    unless index_exists?(:categorizations, :item_id)
      add_index :categorizations, :item_id
    end
    
    # Check if the composite index exists before adding
    unless index_exists?(:categorizations, [:category_id, :item_id], unique: true)
      add_index :categorizations, [:category_id, :item_id], unique: true
    end
  end
end
