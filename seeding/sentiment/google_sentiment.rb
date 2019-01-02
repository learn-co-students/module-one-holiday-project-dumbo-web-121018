require_relative '../../config/environment'

project_id = 1036024684452
key_file   = "../../QuoteMoods-49b82bfb96bd.json"

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
    quote.save
  end
end

analyze_assign_sentiment
