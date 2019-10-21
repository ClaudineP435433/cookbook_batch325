class Recipe
  attr_reader :name, :description, :prep_time, :difficulty

  def initialize( attributes = {} )
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false
    @difficulty = attributes[:difficulty]
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end

# Recipe.new('Tarte', 'oeufs')

# Recipe.new({name: 'Tarte', description: 'oeufs'})

# Recipe.new(name: 'Tarte', description: 'oeufs')


# Si tu ajoutes une interface/action utilisateur
# Ajout du router
# Ajout dans le controller de la méthode associée
# dans cette méthode, liste les actions utilisateurs

# Si tu ajoutes une variable d'instance (prep_time, done, difficulty)
# 1. Modele
# 2. Repo
# 3. Controller
# 4. View
# Router et Service
