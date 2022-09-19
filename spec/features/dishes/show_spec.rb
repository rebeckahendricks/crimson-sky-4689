require 'rails_helper'

RSpec.describe 'Dish Show Page' do
  describe 'As a visitor' do
    describe 'When I visit a dishs show page' do
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

      it 'I see the dishs name and description' do
        visit dish_path(@dish1)

        expect(page).to have_content("Beef Wellington")
        expect(page).to have_content("Delicious beef dish")
        expect(page).to_not have_content("Spaghetti")
        expect(page).to_not have_content("Noodles & red sauce")
      end

      it 'I see a list of ingredients for that dish' do
        visit dish_path(@dish1)

        expect(page).to have_content("Ground beef")
        expect(page).to have_content("Pate")
        expect(page).to have_content("Mushrooms")
        expect(page).to_not have_content("Noodles")
      end

      it 'I see the chefs name' do
        visit dish_path(@dish1)

        expect(page).to have_content("Gordon Ramsay")
      end

      it 'I see the total calorie count for that dish' do
        visit dish_path(@dish1)

        expect(page).to have_content("Total Calories: 950")
      end
    end
  end
end
