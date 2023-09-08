class ShoppingListController < ApplicationController
  skip_load_and_authorize_resource only: :index

  def index
    selected_recipe_id = params[:selected_recipe_id]
    if selected_recipe_id.present?
      if Recipe.exists?(selected_recipe_id)
        @recipe = Recipe.includes(recipe_foods: :food).find_by(id: selected_recipe_id)
        @shopping_list_items = @recipe.recipe_foods
        @total_value = @shopping_list_items.sum do |ingredient|
          value = ingredient.quantity * ingredient.food.price / ingredient.food.quantity
          value.round(2)
        end
      else
        flash[:alert] = 'The selected recipe has been deleted. Select a new one.'
        @shopping_list_items = []
      end
    else
      flash[:alert] = 'You have not selected any recipe yet'
      @shopping_list_items = []
    end
  end
end
