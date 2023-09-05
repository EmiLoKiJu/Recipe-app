class FoodsController < ApplicationController
  def edit
    @foods = Food.find(params[:id])
  end
end