class FoodsController < ApplicationController
  def index
    @foods = current_user.foods
  end

  def edit
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])

    # Find and delete associated recipe_foods records
    RecipeFood.where(food_id: @food.id).destroy_all

    @food.destroy
    redirect_back_or_to root_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
