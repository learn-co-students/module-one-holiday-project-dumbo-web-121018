# reveals the sentiment of an author given the name as an argument
def author_score
  prompt = TTY::Prompt.new
  name = prompt.select('Select an author to find their mood.') do |menu|
      Author.all.select do |author|
        menu.choice author.name
    end
  end
  score_sum = Author.all.find_by(name: name).quotes.sum(:score)
  magnitude_sum = Author.all.find_by(name: name).quotes.sum(:magnitude)
  quote_count = Author.all.find_by(name: name).quotes.length
  score = score_sum / quote_count
  magnitude = magnitude_sum / quote_count
  positive_count = Author.all.find_by(name: name).quotes.where("sentiment = 'positive'").count
  negative_count = Author.all.find_by(name: name).quotes.where("sentiment = 'negative'").count
  neutral_count = negative_count = Author.all.find_by(name: name).quotes.where("sentiment = 'neutral'").count
  Rothko::Drawing.new(Author.all.find_by(name: name).img_url, 30)
  if score > 0.5 && magnitude > 0.4
    puts "Based on this sample of quotes, it would seem that #{name} is very positive!"
  elsif score > 0.1 && magnitude > 0.2
    puts "Based on this sample of quotes, it would seem that #{name} is somewhat positive."
  elsif score < 0 && magnitude > 0.5
    puts "Based on this sample of quotes, it would seem that #{name} is very negative."
  elsif score < 0 && magnitude > 0.2
    puts "Based on this sample of quotes, it would seem that #{name} is somewhat negative."
  elsif (0..0.19).include?(magnitude)
    puts "Based on this samle of quotes, it would seem that #{name} is pretty neutral"
  else (0...0.1).include?(score) && magnitude > 0.1
    puts "Based on this samle of quotes, it would seem that #{name} is a mixed bag!"
  end
  puts "Score: #{score}"
  puts "Magnitude: #{magnitude}"
  puts "#{name} has #{positive_count} positive quotes,  #{negative_count} negative quotes, and #{neutral_count} neutral quotes."
  menu
end
