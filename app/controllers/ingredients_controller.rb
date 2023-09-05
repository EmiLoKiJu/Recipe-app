class IngredientsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = Ingredient.new
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.recipe = @recipe

    if @ingredient.save
      redirect_to @ingredient.recipe
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      redirect_to @ingredient.recipe
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @recipe = @ingredient.recipe
    @ingredient.destroy

    redirect_to @recipe
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:food_id, :quantity)
  end
end
