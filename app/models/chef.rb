class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes

  def unique_ingredients
    dishes
    .select('ingredients.*')
    .joins(:ingredients)
    .distinct
  end
end
