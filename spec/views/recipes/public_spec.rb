RSpec.feature 'Public Recipes View', type: :system do
  # Load the fixture data
  fixtures :users, :recipes

  before do
    # Sign in as a user (optional)
    user = users(:one)
    sign_in user if user # Assuming there's a user fixture for this test
  end

  scenario 'user views public recipes' do
    # Create some public recipes for testing
    recipe1 = recipes(:one)
    recipes(:two)

    visit public_recipes_path

    if page.has_no_css?('div.max-w-4xl')
      # No public recipes found
      expect(page).to have_content("Hello! We don't have any recipes yet!")
      expect(page).to have_content('Please be the first to create one!')

      if user
        # User is signed in
        expect(page).to have_link('Create a recipe', href: new_recipe_path)
      else
        # User is not signed in
        expect(page).to have_link('Login', href: new_user_session_path)
      end
    else
      # At least one public recipe found
      expect(page).to have_css('div.max-w-4xl', count: 1)

      # Check each public recipe's details
      within('div.max-w-4xl', match: :first) do
        expect(page).to have_link(recipe1.name, href: recipe_path(recipe1))
        expect(page).to have_content("By: #{recipe1.user.name}")
        expect(page).to have_content("Total food items: #{recipe1.foods.length}")
      end
    end
  end
end
