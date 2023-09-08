RSpec.feature "ShoppingList", type: :system do
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

    # Check that the page displays the total value of food needed
    expect(page).to have_content('Total value of food needed: $1.63')

    # Check that the page displays the correct shopping list items
    expect(page).to have_content('Spaghetti')
    expect(page).to have_content('400 grams')
    expect(page).to have_content('$0.40')

    expect(page).to have_content('Bacon')
    expect(page).to have_content('150 grams')
    expect(page).to have_content('$0.60')

    expect(page).to have_content('Eggs')
    expect(page).to have_content('4 pieces')
    expect(page).to have_content('$0.13')

    expect(page).to have_content('Cheese')
    expect(page).to have_content('50 grams')
    expect(page).to have_content('$0.50')
  end
end