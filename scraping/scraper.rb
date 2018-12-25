require 'nokogiri'
require 'open-uri'
require 'pry'

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

binding.pry
