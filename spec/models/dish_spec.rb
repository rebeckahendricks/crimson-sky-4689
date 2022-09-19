require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many(:ingredients).through(:dish_ingredients)}
    it {should have_many(:dish_ingredients)}
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
    end

    describe '#total_calories' do
      it 'can calculate the total calories in a dish' do
        expect(@dish1.total_calories).to eq(950)
        expect(@dish2.total_calories).to eq(400)
      end
    end
  end
end
