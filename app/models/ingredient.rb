class Ingredient < ApplicationRecord
  def value
    quantity * food.price if quantity.present?
  end
end
