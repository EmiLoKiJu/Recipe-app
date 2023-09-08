RSpec.feature 'Adding Food to Recipe', type: :system do
  # Load the fixture data if needed
  fixtures :users, :recipes, :foods

  before do
    # Sign in as a user (optional)
    user = users(:one)
    sign_in user if user # Assuming there's a user fixture for this test
  end

  scenario 'user adds food to a recipe' do
    # Create a food for testing (if needed)
    food = foods(:one)

    # Visit the new recipe_food page
    visit new_recipe_food_path(recipe_id: recipes(:one).id)

    # Fill in the form fields
    select food.name, from: 'recipe_food_food_id' # Use the actual form field name
    fill_in 'Quantity', with: '100' # Use the actual form field label

    # Submit the form
    click_button 'Add Food'

    # Check that the user is redirected to the recipe show page
    expect(page).to have_current_path(recipe_path(recipes(:one).id))

    # Check that the page displays a success notice
    expect(page).to have_content('Food added to recipe successfully.')

    # You can also check other details on the recipe show page if needed
    expect(page).to have_content(food.name)
    expect(page).to have_content('100')
  end
end
