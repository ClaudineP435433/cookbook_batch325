require 'csv'

class Cookbook

  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file
    load_csv
  end

  def all
    @recipes
  end

  def add(recipe)
    @recipes << recipe
    save_csv
  end

  def remove(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_recipe_as_done(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    save_csv
  end

  def load_csv
    # csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # done = row[:done] == 'true' ? true : false
      row[:done] = (row[:done] == 'true')
      @recipes << Recipe.new(name: row[:name], description: row[:description], prep_time: row[:prep_time], done: row[:done], difficulty: row[:difficulty])
      # @recipes << Recipe.new(row)
    end
  end

  def save_csv
    # csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file, 'wb') do |csv|
      csv << [ 'name', 'description', 'prep_time', 'done', 'difficulty']
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done?, recipe.difficulty]
      end
      # csv << ['Name', 'Appearance', 'Origin']
    end
  end
end
