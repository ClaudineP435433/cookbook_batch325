require_relative 'recipe'
require 'open-uri'
require 'nokogiri'

class ServiceScrapping

  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{@ingredient}"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    scrapping_results = []
    html_doc.search('.m_contenu_resultat')[0...5].each do |element|
      name = element.search('.m_titre_resultat').text.strip
      description = element.search('.m_texte_resultat').text.strip
      prep_time = element.search('.m_prep_time').first.parent.text.strip
      difficulty = element.search('.m_detail_recette').text.strip.split('-')[2]
      scrapping_results << Recipe.new(name: name, description: description, prep_time: prep_time, difficulty: difficulty)
    end
    return scrapping_results
  end
end
