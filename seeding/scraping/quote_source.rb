require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative '../../config/environment'

Quote.destroy_all

melville = Nokogiri::HTML(open("https://www.goodreads.com/author/quotes/1624.Herman_Melville"))

austen = Nokogiri::HTML(open("https://www.goodreads.com/author/quotes/1265.Jane_Austen"))

morrison = Nokogiri::HTML(open("https://www.goodreads.com/author/quotes/3534.Toni_Morrison"))

baldwin = Nokogiri::HTML(open("https://www.goodreads.com/author/quotes/10427.James_Baldwin"))

murakami = Nokogiri::HTML(open("https://www.goodreads.com/author/quotes/3354.Haruki_Murakami"))

def getQuotes(doc)
  quotes = []
  doc.css(".quoteText").select do |quote|
    if quote.text.length < 560
      quotes << quote.text.strip.split("\n")[0]
    end
  end
  quotes
end

melville_quotes = getQuotes(melville)
austen_quotes = getQuotes(austen)
morrison_quotes = getQuotes(morrison)
baldwin_quotes = getQuotes(baldwin)
murakami_quotes = getQuotes(murakami)

def create_quote(author_id, content_array)
  content_array.each do |content|
    quote = Quote.new
    quote.content = content
    quote.author_id = author_id
    quote.save
  end
end

Quote.destroy_all

create_quote(27, melville_quotes)
create_quote(28, austen_quotes)
create_quote(29, morrison_quotes)
create_quote(30, baldwin_quotes)
create_quote(31, murakami_quotes)
