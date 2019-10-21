class View

  def display(recipes)
    puts '------COOKBOOK------'
    recipes.each_with_index do |recipe, index|
      done = recipe.done? ? '[X]' : '[ ]'
      puts "#{index + 1} #{done} - #{recipe.name} - #{recipe.description} - #{recipe.prep_time} - #{recipe.difficulty}"
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
