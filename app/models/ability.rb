class Ability
  include CanCan::Ability

  def initialize(user)
    # starting rules for all users
    can :read, Food
    can :read, Recipe do |recipe|
      recipe.is_public == true
    end

    # additional permissions for logged in users
    return unless user.present?

    can :manage, Recipe do |recipe|
      recipe.user == user
    end

    can :destroy, Food do |food|
      food.user == user
    end

    can :manage, RecipeFood do |recipe_food|
      recipe_food.recipe.user == user
    end

    can :create, Food
    can :create, Recipe
    can :create, RecipeFood
  end
end
