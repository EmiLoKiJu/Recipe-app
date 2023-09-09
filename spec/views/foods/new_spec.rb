RSpec.feature 'New Food Form', type: :system do
  # Load the fixture data if needed
  fixtures :users

  before do
    # Sign in as a user (assuming there's a user fixture)
    user = users(:one)
    sign_in user
  end

  scenario 'user creates a new food' do
    # Visit the new food page
    visit new_food_path

    # Fill in the form fields
    fill_in 'Name', with: 'New Food Name'
    fill_in 'Measurement unit', with: 'Grams'
    fill_in 'Price', with: '5.99'
    fill_in 'Quantity', with: '100'

    # Submit the form
    click_button 'Create Food'

    # Check that the page displays the newly created food details
    expect(page).to have_content('Food was successfully created.')
    expect(page).to have_content('Grams')
    expect(page).to have_content('$5.99')
  end
end
