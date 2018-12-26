require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative '../config/environment'
require_relative '../scraping/scraper'


Author.destroy_all


melville = Author.new
melville.name = "Herman Melville"
melville.save
austen = Author.new
austen.name = "Jane Austen"
austen.save
morrison = Author.new
morrison.name = "Toni Morrisson"
morrison.save
baldwin = Author.new
baldwin.name = "James Baldwin"
baldwin.save
murakami = Author.new
murakami.name = "Haruki Murakami"
murakami.save
