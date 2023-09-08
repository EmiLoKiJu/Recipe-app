require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  it 'is valid with valid attributes' do
    recipe_food = RecipeFood.new(
      quantity: 400,
      recipe: Recipe.new,
      food: Food.new
    )
    expect(recipe_food).to be_valid
  end

  it 'is not valid without a quantity' do
    recipe_food = RecipeFood.new(quantity: nil)
    expect(recipe_food).to_not be_valid
  end

  it 'is not valid with a negative quantity' do
    recipe_food = RecipeFood.new(quantity: -1)
    expect(recipe_food).to_not be_valid
  end
end
