class View

  def display(recipes)
    puts '------COOKBOOK------'
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name} - #{recipe.description}"
    end
  end

  def ask_for(something)
    puts "What's the #{something} of the recipe to add ?"
    print ">"
    gets.chomp
  end

  def ask_for_index
    puts "What's the index of the recipe ?"
    print ">"
    gets.chomp.to_i - 1
  end
end
