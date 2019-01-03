require_relative '../../config/environment'

# Imports the Google Cloud client library
require "google/cloud/language"



def analyze_assign_sentiment
  Quote.all.each do |quote|
    # Instantiates a client
    language = Google::Cloud::Language.new
    # Detects the sentiment of the text
    response = language.analyze_sentiment content: quote.content, type: :PLAIN_TEXT
    # Get document sentiment from response
    sentiment = response.document_sentiment
    puts "#{quote.content}"
    puts "Score: #{sentiment.score}, #{sentiment.magnitude}"
    quote.score = sentiment.score
    quote.magnitude = sentiment.magnitude
    if quote.score > 0.1 && quote.magnitude > 0.2
      quote.sentiment = "positive"
    elsif quote.score < 0 && quote.magnitude > 0.2
      quote.sentiment = "negative"
    elsif (0..0.19).include?(quote.magnitude)
      quote.sentiment = "neutral"
    end
    quote.save
  end
end

analyze_assign_sentiment
