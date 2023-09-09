require 'rails_helper'

RSpec.feature 'RecipesIndex', type: :system do
  # Load the fixture data
  fixtures :users, :recipes, :foods, :recipe_foods
  before do
    # Sign in as the first user
    user = users(:one)
    sign_in user
  end

  scenario 'user visits the recipes index page' do
    visit recipes_path

    # Check that the page has the correct title
    expect(page).to have_title('Recipes')

    # Check that the page displays the recipe names and descriptions
    expect(page).to have_content('Spaghetti Carbonara')
    expect(page).to have_content('A classic Italian dish made with spaghetti, bacon, eggs, and cheese.')

    # Check that the page has a link to add a new recipe
    expect(page).to have_link('Add Recipe', href: new_recipe_path)
  end

  scenario 'user clicks on a recipe name' do
    visit recipes_path

    # Click on the first recipe name
    click_link 'Spaghetti Carbonara'

    # Check that the page redirects to the recipe show page
    expect(page).to have_current_path(recipe_path(recipes(:one).id))
  end

  scenario 'user clicks on the remove button' do
    visit recipes_path

    # Click on the first recipe remove button
    first(:button, 'Remove').click

    # Check that the page redirects to the recipes index page
    expect(page).to have_current_path(recipes_path)

    # Check that the recipe is no longer displayed on the page
    expect(page).not_to have_content('Spaghetti Carbonara')
  end

  scenario 'user clicks on the add recipe button' do
    visit recipes_path

    # Click on the add recipe button
    click_link 'Add Recipe'

    # Check that the page redirects to the new recipe page
    expect(page).to have_current_path(new_recipe_path)
  end
end
