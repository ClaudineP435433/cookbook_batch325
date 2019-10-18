require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    list_all_recipes
  end

  def add_recipe
    #demander à l'utilisateur le nom de la recette
    name = @view.ask_for('name')
    # demander à l'utilisateur la description de la recette
    description = @view.ask_for('description')
    # Créer la recette
    recipe = Recipe.new(name, description)
    # Stocker la recette
    @cookbook.add(recipe)
    list_all_recipes
  end

  def remove_recipe
    # afficher la liste
    list_all_recipes
    # Demander l'index de la recette à supprimer
    index = @view.ask_for_index
    # Supprimer la recette
    @cookbook.remove(index)
    # Afficher la liste
    list_all_recipes
  end

  private

  def list_all_recipes
    # Avoir la liste des recettes
    recipes = @cookbook.all
    # Afficher les recettes
    @view.display(recipes)
  end

end
