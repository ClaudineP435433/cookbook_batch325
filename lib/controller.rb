require_relative 'view'
require_relative 'service_scrapping'
require 'open-uri'
require 'nokogiri'
require 'pry-byebug'


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
    # demander le temps de prépa
    prep_time = @view.ask_for('time to prepare')
    # demander le difficulté
    difficulty = @view.ask_for('difficulte')
    # Créer la recette
    recipe = Recipe.new(name: name, description: description, prep_time: prep_time, difficulty: difficulty)
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

  def import
    # Demander l'aliment à l'utilisateur
    ingredient = @view.ask_for('ingredient')
    scrapping_results = ServiceScrapping.new(ingredient).call
    # Afficher les resultats
    @view.display(scrapping_results)
    # scrapping_results = [R1, R2, R3]
    # Choisir en demandant l'index
    index = @view.ask_for_index
    recipe = scrapping_results[index]
    # Ajouter au cookbook
    @cookbook.add(recipe)
  end

  def mark_recipe_as_done
    # 1. Display recipes
    list_all_recipes
    # 2. Ask user for an index (view)
    index = @view.ask_for_index
    # 3. Mark as done and save (repo)
    @cookbook.mark_recipe_as_done(index)
    # 4. Display recipes
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
