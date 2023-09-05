module RecipesHelper
  def publish(recipe)
    if recipe.public?
      button_to 'Public <i class="fa-solid fa-toggle-on"></i>'.html_safe, publish_recipe_path(recipe)
    else
      button_to 'Public <i class="fa-solid fa-toggle-off"></i>'.html_safe, publish_recipe_path(recipe)
    end
  end
end
