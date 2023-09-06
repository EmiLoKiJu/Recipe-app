class FoodsController < ApplicationController
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
      redirect_to @food, notice: 'Food was successfully created.'
    else
      puts @food.errors.full_messages
      redirect_to new_food_path
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
