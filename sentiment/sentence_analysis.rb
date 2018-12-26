require_relative '../config/environment'
require 'sentimental'

analyzer = Sentimental.new
analyzer.load_defaults

def analyze_assign_sentiment
  analyzer = Sentimental.new
  analyzer.load_defaults
  Quote.all.each do |quote|
    quote.sentiment = analyzer.sentiment quote.content
    quote.score = analyzer.score quote.content
    quote.save
  end
  binding.pry
end

analyze_assign_sentiment




# sentiment = analyzer.sentiment 'Be the reason someone smiles today'
# score = analyzer.score 'Be the reason someone smiles today'
# puts sentiment, score
