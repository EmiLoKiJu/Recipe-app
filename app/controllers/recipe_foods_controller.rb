class RecipeFoodsController < ApplicationController
  before_action :check_recipe_ownership, only: [:new]

  def new
    @recipe_food = RecipeFood.new
    @recipe_food.recipe_id = params[:recipe_id]
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    recipe = Recipe.find(@recipe_food.recipe_id)

    return unless can?(:manage, recipe)

    if @recipe_food.save
      redirect_to @recipe_food.recipe, notice: 'Food added to recipe successfully.'
    else
      puts @recipe_food.errors.full_messages
      redirect_to new_recipe_food_path
    end
  end

  def destroy
    return unless can?(:manage, @recipe_food.recipe)

    @recipe_food = RecipeFood.find(params[:id])
    recipe_id = @recipe_food.recipe_id

    if @recipe_food.destroy
      redirect_to recipe_path(recipe_id), notice: 'Food deleted successfully.'
    else
      puts @recipe_food.errors.full_messages
      redirect_to recipe_path(recipe_id), alert: 'Failed to delete food.'
    end
  end

  def edit
    unless can?(:manage, @recipe_food.recipe)
      redirect_to root_path, alert: 'You do not have permission to edit this food in the recipe.'
      return
    end

    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe_food.recipe), notice: 'Quantity updated successfully.'
    else
      render :edit
    end
  end

  private

  def check_recipe_ownership
    recipe = Recipe.find(params[:recipe_id])
    return if can?(:manage, recipe)

    redirect_to root_path, alert: 'You do not have permission to add food to this recipe.'
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity, :recipe_id)
  end
end
