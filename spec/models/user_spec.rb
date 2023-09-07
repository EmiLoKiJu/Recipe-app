require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: 'hana', email: 'hana@gmail.com', password: '123456')
  end

  context 'Testing Validations' do
    it 'user is valid' do
      @user.save
      expect(@user).to be_valid
    end

    it 'validates name' do
      @user.name = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it 'validates email' do
      @user.email = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it 'validates password' do
      @user.password = nil
      @user.save
      expect(@user).to_not be_valid
    end
  end

  context 'Testing Associations' do
    it 'has_many foods' do
      assoc = User.reflect_on_association(:foods)
      expect(assoc.macro).to eq :has_many
    end

    it 'has_many recipes' do
      assoc = User.reflect_on_association(:recipes)
      expect(assoc.macro).to eq :has_many
    end
  end
end
