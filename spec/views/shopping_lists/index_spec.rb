RSpec.feature 'ShoppingList', type: :system do
  # Load the fixture data
  fixtures :users, :recipes, :foods, :recipe_foods

  before do
    # Sign in as the first user
    user = users(:one)
    sign_in user
  end

  scenario 'user generates a shopping list for a recipe' do
    # Visit the recipe show page for the first recipe
    visit recipe_path(recipes(:one).id)

    # Click on the generate shopping list button
    within('.d-flex.justify-content-between.mb-4') do
      click_link 'Generate shopping list'
    end

    # Check that the page redirects to the shopping list page
    expect(page).to have_current_path(general_shopping_list_path(selected_recipe_id: recipes(:one).id))

    # Check that the page has the correct title
    expect(page).to have_content('Shopping List')

    # Check that the page displays the correct output
    expect(page).to have_content('You have all the required ingredients for this recipe!')
  end

  scenario 'user does not have any food' do
    user = User.find_by(email: 'john@example.com')
    user.foods.update(quantity: 0)

    visit recipe_path(recipes(:one).id)

    # Click on the generate shopping list button
    within('.d-flex.justify-content-between.mb-4') do
      click_link 'Generate shopping list'
    end

    # Check that the page redirects to the shopping list page
    expect(page).to have_current_path(general_shopping_list_path(selected_recipe_id: recipes(:one).id))

    expect(page).to have_content('Spaghetti')
    expect(page).to have_content('400.0 grams')
    expect(page).to have_content('$200')

    expect(page).to have_content('Bacon')
    expect(page).to have_content('150.0 grams')
    expect(page).to have_content('$120.0')

    expect(page).to have_content('Eggs')
    expect(page).to have_content('4.0 pieces')
    expect(page).to have_content('$0.8')

    expect(page).to have_content('Cheese')
    expect(page).to have_content('50.0 grams')
    expect(page).to have_content('$50.0')
  end
end
