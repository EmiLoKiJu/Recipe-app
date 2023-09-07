class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    @recipe_food.recipe_id = params[:recipe_id]
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    if @recipe_food.save
      redirect_to @recipe_food.recipe, notice: 'Food added to recipe successfully.'
    else
      puts @recipe_food.errors.full_messages
      redirect_to new_recipe_food_path
    end
  end

  def destroy
    authorize! :destroy, @recipe_food
    @recipe_food = RecipeFood.find(params[:id])
    recipe_id = @recipe_food.recipe_id
    if @recipe_food.destroy
      redirect_to recipe_path(recipe_id), notice: 'Food deleted successfully.'
    else
      puts @recipe_food.errors.full_messages
      redirect_to recipe_path(recipe_id), alert: 'Failed to delete food.'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity, :recipe_id)
  end
end
