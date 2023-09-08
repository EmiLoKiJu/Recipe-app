RSpec.feature "Viewing List of Foods", type: :system do
  # Load the fixture data if needed
  fixtures :users, :foods

  before do
    # Sign in as a user
    user = users(:one)
    sign_in user if user # Assuming there's a user fixture for this test
  end

  scenario 'user views the list of foods' do
    # Create some foods for testing (if needed)
    food1 = foods(:one)
    food2 = foods(:two)

    # Visit the foods index page
    visit foods_path

    if page.has_no_css?('table.table-bordered')
      # No foods found
      expect(page).to have_content("Hello! We don't have any food!")
    else
      # At least one food found
      expect(page).to have_css('table.table-bordered', count: 1)

      # Check each food's details
      within('table.table-bordered tbody') do
        expect(page).to have_content(food1.name)
        expect(page).to have_content(food1.measurement_unit)
        expect(page).to have_content(food1.price)

        expect(page).to have_content(food2.name)
        expect(page).to have_content(food2.measurement_unit)
        expect(page).to have_content(food2.price)
      end
    end
  end

  scenario 'user removes a food from the list' do
    # Create a food for testing
    food_to_remove = foods(:one)
  
    # Visit the foods index page
    visit foods_path
  
    # Find and click the delete link for the specific food
    within('table.table-bordered tbody') do
      find("[href='#{food_path(food_to_remove)}']").click
    end
  
    # Check that the user is redirected back to the foods index page
    expect(page).to have_current_path(foods_path)
  
    # Check that the page displays a success notice (adjust to your application)
    expect(page).to have_content('Food removed successfully.')
  
    # Check that the removed food is not in the list anymore
    expect(page).not_to have_content(food_to_remove.name)
    expect(page).not_to have_content(food_to_remove.measurement_unit)
    expect(page).not_to have_content(food_to_remove.price)
  end
end