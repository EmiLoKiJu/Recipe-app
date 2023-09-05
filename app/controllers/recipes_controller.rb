class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[public show]
  skip_authorize_resource only: :public

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    authorize! :read, @recipe
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @recipe = Recipe.new
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    @recipe.destroy
    redirect_to recipes_path
  end

  def public
    @totals = {}

    @public_recipes = Recipe.where(public: true).includes(:foods, :user).order('created_at DESC')
    @public_recipes.each do |pub|
      total = 0
      RecipeFood.where(recipe_id: pub.id).each do |rec_food|
        total += rec_food.quantity * rec_food.food.price
      end
      @totals[pub.id] = total
    end
  end

  def publish
    @recipe = Recipe.find(params[:id])
    @recipe.public = !@recipe.public

    redirect_to @recipe if @recipe.save
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
