class ShoppingListController < ApplicationController
  skip_load_and_authorize_resource only: :index

  def index
    selected_recipe_id = params[:selected_recipe_id]
    puts "Selected recipe ID: #{selected_recipe_id.inspect}"
    if selected_recipe_id.present?
      @recipe = Recipe.find(selected_recipe_id)
      @shopping_list_items = @recipe.foods
    else
      @shopping_list_items = []
    end
  end
end
