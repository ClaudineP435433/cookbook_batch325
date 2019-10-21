require "open-uri"
require "nokogiri"
require_relative "recipe"
require_relative "view"
require 'pry-byebug'

class ScrapeMarmitonService
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    html = open("http://www.marmiton.org/recettes/recherche.aspx?aqt=#{@ingredient}").read
    # 1. Parse HTML
    doc = Nokogiri::HTML(html, nil, "utf-8")
    # 2. For the first five results
    results = []
    doc.search(".recipe-card").first(5).each do |element|
      # 3. Create recipe and store it in results
      name = element.search('.recipe-card__title').text.strip
      description = element.search('.recipe-card__description').text.strip
      prep_time = element.search('.recipe-card__duration__value').text.strip
      link_part_second_page = element.search('.recipe-card-link').attribute('href').value
      difficulty = call_second_page(link_part_second_page)
      results << Recipe.new(name: name, description: description, prep_time: prep_time, difficulty: difficulty)
    end
    return results
  end

  def call_second_page(link_part)
    url = "http://www.marmiton.org#{link_part}"
    html = open(url).read
    # 1. Parse HTML
    doc = Nokogiri::HTML(html, nil, "utf-8")
    doc.search('.recipe-infos__level .recipe-infos__item-title').text.strip
  end
end

view = View.new
results = ScrapeMarmitonService.new('fraise').call
view.display(results)
