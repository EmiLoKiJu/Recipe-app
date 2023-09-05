class ShoppingListsController < ApplicationController
  skip_load_and_authorize_resource only: :index

  def index
    @shopping_list = Ingredient.joins(:recipe).where(recipes: { user_id: current_user.id }).includes(:food)
    @shopping_list_value = @shopping_list.sum { |ingredient| ingredient.food.price * ingredient.quantity }
  end
end
