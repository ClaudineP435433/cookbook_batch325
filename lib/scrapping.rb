require 'open-uri'
require 'nokogiri'
require 'pry-byebug'

ingredient = 'chocolate'
url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{ingredient}"

html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.m_contenu_resultat').each do |element|
  name = element.search('.m_titre_resultat').text.strip
  description = element.search('.m_texte_resultat').text.strip
end
