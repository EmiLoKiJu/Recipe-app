require 'rails_helper'

RSpec.describe 'Recipe Index', type: :system do
  before(:each) do
    @user = User.new(name: 'mohamed', email: 'gigiyoyo2001@yahoo.com', encrypted_password: '123456')

    @recipe = Recipe.create(user_id: @user.id, name: 'Pizza', preparation_time: '2', cooking_time: '3',
                            description: 'Amazing hot pizza')
  end

  it 'User should log in' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    sleep(2)
    fill_in 'Password', with: @user.encrypted_password
    click_button('Log in')
    sleep(3)
  end

  it 'User should be able to create a new Recipe' do
    visit root_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.encrypted_password
    sleep(3)
    click_button('Log in')

    click_link('recipes')
    sleep(2)
    click_link 'Add Recipe'

    fill_in 'Name', with: @recipe.name
    sleep(3)
    fill_in 'Preparation time', with: @recipe.preparation_time
    fill_in 'Cooking time', with: @recipe.cooking_time
    fill_in 'Description', with: @recipe.description
    click_button('Add recipe')
    sleep(3)
  end
end
