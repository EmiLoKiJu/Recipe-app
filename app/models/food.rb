class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  has_many :ingredients, dependent: :destroy
  has_many :recipes, through: :ingredients

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
