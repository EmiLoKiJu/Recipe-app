class ShoppingListController < ApplicationController
  skip_load_and_authorize_resource only: :index

  def index
    selected_recipe_id = params[:selected_recipe_id]
    if selected_recipe_id.present?
      @shopping_list_items = []
      if Recipe.exists?(selected_recipe_id)
        @recipe = Recipe.includes(recipe_foods: :food).find_by(id: selected_recipe_id)
        @recipe.recipe_foods.each do |recipe_food|
          if current_user.foods.find_by(name: recipe_food.food.name).present?
            @current_user_food = current_user.foods.find_by(name: recipe_food.food.name)
            difference = recipe_food.quantity - @current_user_food.quantity
            @shopping_list_items << [recipe_food, difference] if difference.positive?
          else
            new_food = Food.new(
              name: recipe_food.food.name,
              measurement_unit: recipe_food.food.measurement_unit,
              price: recipe_food.food.price,
              quantity: 0,
              user: current_user
            )
            if new_food.save
              @shopping_list_items << [recipe_food, recipe_food.quantity]
            else
              flash[:alert] = 'An error occurred while creating a new food.'
            end
          end
          @total_value = @shopping_list_items.sum do |ingredient|
            ingredient[1] * ingredient[0].food.price
          end
        end
      else
        flash[:alert] = 'The selected recipe has been deleted. Select a new one.'
      end
    else
      flash[:alert] = 'You have not selected any recipe yet'
      @shopping_list_items = []
    end
  end
end
