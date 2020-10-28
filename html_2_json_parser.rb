require 'nokogiri'
require 'open-uri'
require 'json'

doc = Nokogiri::HTML(URI.open("http://localhost:4567/salads/"))
chapter = Hash.new
recipes = Array.new

doc.search("div.recipe").each do |recipe|
  recipe_hash = Hash.new
  # Title
  recipe_hash[:title] = recipe.at("div.title > h2").text

  # Author
  recipe_hash[:author] = "Jane Larson"

  # Ingredients
  recipe_hash[:ingredients] = Array.new
  recipe.search("div.ingredients").each do |ing|

    ingredients = Hash.new
    ingredients[:label] = ing.at("h3").text

    ingredients[:list] = Array.new
    ing.search("ul > li").each do |item|
      ingredients[:list] << item.text
    end

    recipe_hash[:ingredients] << ingredients
  end

  # Directions
  recipe_hash[:instructions] = Array.new
  recipe.search("div.directions > p").each do |dir|
    recipe_hash[:instructions] << dir.text
  end

  # Images
  recipe_hash[:images] = Array.new
  recipe.search("div.image > img").each do |img|
    recipe_hash[:images] << img['src']
  end

  # Notes
  recipe_hash[:notes] = Array.new
  recipe.search("div.notes > p").each do |note|
    recipe_hash[:notes] << note.text
  end

  recipe_hash[:print_image] = true
  recipes << recipe_hash
end

chapter[:recipes] = recipes
puts chapter.to_json
