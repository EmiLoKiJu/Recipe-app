require 'rails_helper'
RSpec.describe Recipe, type: :model do
  before :each do
    @user = User.new(name: 'hana', email: 'hana@gmail.com', password: '123456')
    @recipe = Recipe.new(user: @user, name: 'fish', preparation_time: 35, cooking_time: 20,
                         description: 'grilled fish', is_public: true)
  end

  context 'Testing Validations' do
    it 'recipe is valid' do
      expect(@recipe).to be_valid
    end
  end

  context 'Testing Associations' do
    it 'has_many foods' do
      assoc = Recipe.reflect_on_association(:foods)
      expect(assoc.macro).to eq :has_many
    end
    it 'belongs_to user' do
      assoc = Recipe.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
