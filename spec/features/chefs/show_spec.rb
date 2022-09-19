require 'rails_helper'

RSpec.describe 'Chef Show Page' do
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

  describe 'As a visitor' do
    describe 'When I visit a chefs show page' do
      it 'I see the name of that chef' do
        visit chef_path(@chef)

        expect(page).to have_content("Gordon Ramsay")
        expect(page).to_not have_content("Rachel Ray")
      end

      it 'I see a link to view a list of all ingredients that this chef uses in their dishes' do
        visit chef_path(@chef)

        expect(page).to have_link("Ingredients Used")
      end

      describe 'When I click that link' do
        it 'I am taken to a chefs ingredient index page' do
          visit chef_path(@chef)
          click_link("Ingredients Used")
          expect(current_path).to eq(chef_ingredients_path(@chef))
        end

        it 'I can see a unique list of names of all the ingredients that this chef uses' do
          visit chef_ingredients_path(@chef)

          expect(page).to have_content("Ground beef", count: 1)
          expect(page).to have_content("Pate", count: 1)
          expect(page).to have_content("Mushrooms", count: 1)
          expect(page).to have_content("Noodles", count: 1)
        end
      end
    end
  end
end
