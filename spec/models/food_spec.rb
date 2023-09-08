require 'rails_helper'

RSpec.describe Food, type: :model do
  it 'is valid with valid attributes' do
    food = Food.new(
      name: 'Spaghetti',
      measurement_unit: 'grams',
      price: 0.5,
      quantity: 500,
      user: User.new
    )
    expect(food).to be_valid
  end

  it 'is not valid without a name' do
    food = Food.new(name: nil)
    expect(food).to_not be_valid
  end

  it 'is not valid without a measurement unit' do
    food = Food.new(measurement_unit: nil)
    expect(food).to_not be_valid
  end

  it 'is not valid without a price' do
    food = Food.new(price: nil)
    expect(food).to_not be_valid
  end

  it 'is not valid without a quantity' do
    food = Food.new(quantity: nil)
    expect(food).to_not be_valid
  end

  it 'is not valid with a negative price' do
    food = Food.new(price: -1)
    expect(food).to_not be_valid
  end

  it 'is not valid with a negative quantity' do
    food = Food.new(quantity: -1)
    expect(food).to_not be_valid
  end
end
