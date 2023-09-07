# spec/features/shopping_list_spec.rb

require 'rails_helper'

RSpec.feature 'Shopping List Page' do
  before do
    # You can set up any necessary data or variables here.
    @user = User.new(name: 'mohamed', email: 'gigiyoyo2001@yahoo.com', encrypted_password: '123456')

    @recipe = Recipe.create(user_id: @user.id, name: 'Pizza', preparation_time: '2', cooking_time: '3',
                            description: 'Amazing hot pizza')
  end

  scenario 'User visits the shopping list page' do
    # Visit the shopping list page
    visit shopping_lists_path

    # Add expectations based on the content of the page
    expect(page).to have_css('h1', text: 'Shopping List')

    # Replace these expectations with actual values you expect to see on the page
    expect(page).to have_css('.fs-5', text: 'Total value of food needed:')
    expect(page).to have_css('.table-responsive')
    expect(page).to have_css('table.table-bordered')

    # You can add more expectations for table content
    within('table.table-bordered') do
      expect(page).to have_css('th', text: 'Food')
      expect(page).to have_css('th', text: 'Quantity')
      expect(page).to have_css('th', text: 'Price')

      # You can add expectations for table rows and data here
      expect(page).to have_css('tr', count: @shopping_list_items.count + 1) # +1 for the header row
    end
  end
end
