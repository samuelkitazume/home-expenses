class Category < ApplicationRecord
  has_many :categorizations
  has_many :items, through: :categorizations
end
