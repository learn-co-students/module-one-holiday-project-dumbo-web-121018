def add_quote
  new_quote = Quote.new
  prompt = TTY::Prompt.new
  name = prompt.select('Select an author to add a quote.') do |menu|
      Author.all.select do |author|
        menu.choice author.name
    end
  end
  new_quote.author_id = Author.all.find_by(name: name).id
  new_quote.content = prompt.ask("What is the quote?")
  # Instantiates a client
  language = Google::Cloud::Language.new
  # Detects the sentiment of the text
  response = language.analyze_sentiment content: new_quote.content, type: :PLAIN_TEXT
  # Get document sentiment from response
  sentiment = response.document_sentiment
  new_quote.score = sentiment.score
  new_quote.magnitude = sentiment.magnitude
  if new_quote.score > 0.1 && new_quote.magnitude > 0.2
    new_quote.sentiment = "positive"
  elsif new_quote.score < 0 && new_quote.magnitude > 0.2
    new_quote.sentiment = "negative"
  elsif (0..0.19).include?(new_quote.magnitude)
    new_quote.sentiment = "neutral"
  end
  new_quote.save
  menu
end
