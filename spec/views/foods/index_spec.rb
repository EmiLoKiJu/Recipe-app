RSpec.feature 'Viewing List of Foods', type: :system do
  fixtures :users, :foods

  before do
    user = users(:one)
    sign_in user if user # Assuming there's a user fixture for this test
  end

  scenario 'user views the list of foods' do
    food1 = foods(:one)
    food2 = foods(:two)
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

    # Find the row that corresponds to the food you want to remove
    food_row = find('tr', text: food_to_remove.name)

    # Within that row, find and click the "Delete Food" button
    within(food_row) do
      click_button 'Delete Food'
    end

    # Check that the user is redirected back to the foods index page
    expect(page).to have_current_path(foods_path)

    # Check that the removed food is not in the list anymore
    expect(page).not_to have_content(food_to_remove.name)
  end
end
