RSpec.feature 'New Recipe Form', type: :system do
  # Load the fixture data
  fixtures :users

  before do
    # Sign in as a user
    user = users(:one)
    sign_in user
  end

  scenario 'user creates a new recipe' do
    # Visit the new recipe page
    visit new_recipe_path

    # Fill in the form fields
    fill_in 'Name', with: 'New Recipe Name'
    fill_in 'Preparation time', with: '0.5'
    fill_in 'Cooking time', with: '0.75'
    fill_in 'Description', with: 'A delicious new recipe.'
    choose 'recipe_public_false'

    # Submit the form
    click_button 'Add recipe'

    # Check that the page displays the newly created recipe details
    expect(page).to have_content('New Recipe Name')
    expect(page).to have_content('Preparation time: 0.5 hours')
    expect(page).to have_content('Cooking time: 0.75 hours')
    expect(page).to have_content('A delicious new recipe.')
    expect(page).to have_content('Publish')
  end
end
