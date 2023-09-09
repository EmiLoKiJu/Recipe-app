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
    existing_food = current_user.foods.find_by(name: food_params[:name].strip.capitalize)
    if existing_food
      existing_food.quantity += food_params[:quantity].to_f
      existing_food.price = food_params[:price].to_f
      if existing_food.save
        redirect_to foods_path, notice: 'Quantity added to existing food.'
      else
        render :new
      end
    else
      # If no existing food with the same name is found, create a new one
      @food = Food.new(food_params)
      @food.name = @food.name.strip.capitalize
      @food.measurement_unit = @food.measurement_unit.strip.capitalize
      @food.user = current_user
      if @food.save
        redirect_to foods_path, notice: 'Food was successfully created.'
      else
        render :new
      end
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
