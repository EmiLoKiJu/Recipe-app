require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it 'is valid with valid attributes' do
    recipe = Recipe.new(
      name: 'Spaghetti Carbonara',
      preparation_time: 15,
      cooking_time: 15,
      description: 'A classic Italian dish made with spaghetti, bacon, eggs, and cheese.',
      is_public: true,
      user: User.new
    )
    expect(recipe).to be_valid
  end

  it 'is not valid without a name' do
    recipe = Recipe.new(name: nil)
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a preparation time' do
    recipe = Recipe.new(preparation_time: nil)
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a cooking time' do
    recipe = Recipe.new(cooking_time: nil)
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a description' do
    recipe = Recipe.new(description: nil)
    expect(recipe).to_not be_valid
  end

  it 'is not valid with a negative preparation time' do
    recipe = Recipe.new(preparation_time: -1)
    expect(recipe).to_not be_valid
  end

  it 'is not valid with a negative cooking time' do
    recipe = Recipe.new(cooking_time: -1)
    expect(recipe).to_not be_valid
  end

  describe '#public?' do
    it 'returns true if the recipe is public' do
      recipe = Recipe.new(is_public: true)
      expect(recipe.public?).to be true
    end

    it 'returns false if the recipe is not public' do
      recipe = Recipe.new(is_public: false)
      expect(recipe.public?).to be false
    end
  end
end
