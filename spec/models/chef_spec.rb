require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
  end

  describe 'instance methods' do
    before :each do
      @chef = Chef.create!(name: "Gordon Ramsay")
      @chef2 = Chef.create!(name: "Rachel Ray")

      @dish1 = Dish.create!(name: "Beef Wellington", description: "Delicious beef dish", chef_id: @chef.id)
      @dish2 = Dish.create!(name: "Spaghetti", description: "Noodles & red sauce", chef_id: @chef.id)

      @beef = Ingredient.create!(name: "Ground beef", calories: 500)
      @pate = Ingredient.create!(name: "Pate", calories: 300)
      @mushroom = Ingredient.create!(name: "Mushrooms", calories: 150)
      @pasta = Ingredient.create!(name:"Noodles", calories: 250)

      DishIngredient.create!(dish_id: @dish1.id, ingredient_id: @beef.id)
      DishIngredient.create!(dish_id: @dish1.id, ingredient_id: @pate.id)
      DishIngredient.create!(dish_id: @dish1.id, ingredient_id: @mushroom.id)
      DishIngredient.create!(dish_id: @dish2.id, ingredient_id: @pasta.id)
      DishIngredient.create!(dish_id: @dish2.id, ingredient_id: @mushroom.id)
      DishIngredient.create!(dish_id: @dish2.id, ingredient_id: @beef.id)
    end

    describe '#unique_ingredients' do
      it 'can create a unique list of all ingredients a chef uses in all of their dishes' do
        expect(@chef.unique_ingredients.pluck('ingredients.name')).to eq([@beef.name, @mushroom.name, @pasta.name, @pate.name])
      end
    end
  end
end
