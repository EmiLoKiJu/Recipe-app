class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  has_many :ingredients, dependent: :destroy
  has_many :foods, through: :ingredients

  def public?
    public
  end
end
