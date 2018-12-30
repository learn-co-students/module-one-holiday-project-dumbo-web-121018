require_relative '../config/environment'
# require 'artii'
# require 'tty-prompt'


# Welcomes new or returning user to game
def welcome
  a = Artii::Base.new
  puts Rainbow(a.asciify('Mood Quiz!!!')).purple
  prompt = TTY::Prompt.new
  username = prompt.ask('What is your name?')
  if User.find_by(name: username) == nil
    new_user = User.new
    new_user.name = username
    new_user.save
    puts "Welcome #{username}"
  else
    puts "Welcome back #{username}"
  end
  current_user = User.find_by(name: username)
  current_user.logged_in = true
  current_user.save
end

# sorts the mainly positive half of the quotes into one group
def positive_quotes
  Quote.all.select do |quote|
    # binding.pry
    quote.score > 0.05
  end

end
# sorts the mainly negative half into another group
def negative_quotes
  Quote.all.select do |quote|
    quote.score < 0.05
  end
end

# reveals the sentiment of an author given the name as an argument
def author_score
  prompt = TTY::Prompt.new
  name = prompt.select('Select an author to find their mood') do |menu|
    menu.choice Author.all[0].name
    menu.choice Author.all[1].name
    menu.choice Author.all[2].name
    menu.choice Author.all[3].name
    menu.choice Author.all[4].name
  end
  score_sum = Author.all.find_by(name: name).quotes.sum(:score)
  quote_count = Author.all.find_by(name: name).quotes.length
  score = score_sum / quote_count
  positive_count = Author.all.find_by(name: name).quotes.where("sentiment = 'positive'").count
  negative_count = Author.all.find_by(name: name).quotes.where("sentiment = 'negative'").count
  neutral_count = negative_count = Author.all.find_by(name: name).quotes.where("sentiment = 'neutral'").count
  if score >= 0.25
    puts "Based on this sample of quotes, it would seem that #{name} is pretty positive!"
  elsif score < 0.25 && score > -0.25
    puts "Based on this sample of quotes, it would seem that #{name} is pretty neutral."
  else score <= -0.25
    puts "Based on this sample of quotes, it would seem that #{name} is pretty negative."
  end
  puts "#{name} has #{positive_count} positive quotes,  #{negative_count} negative quotes, and #{neutral_count} neutral quotes."
  menu
end

# mood quiz method
def quiz
  prompt = TTY::Prompt.new(active_color: :cyan)
  i = 0
  while i < positive_quotes.length
    answer = prompt.select('Which quote?') do |menu|
      menu.choice positive_quotes[i].content
      menu.choice name: negative_quotes[i].content
    end
    new_liked = Liked.new
    new_liked.user_id = User.find_by(logged_in: true).id
    new_liked.quote_id = Quote.find_by(content: answer).id
    new_liked.save
    i += 1
  end
  menu
end

# options menu
def menu
  prompt = TTY::Prompt.new
  select = prompt.select('What would you like to do?') do |menu|
    menu.choice "Take the quiz",  value: 1
    menu.choice "See author moods", value: 2
    menu.choice "See my mood", value: 3
    menu.choice "Logout", value: 4
  end
  if select[:value] == 1
    quiz
  elsif select[:value] == 2
    author_score
  elsif select[:value] ==3
    user_score
  else
    logout
  end
end



# determines user mood
def user_score
  user = User.all.find_by(logged_in: true)

  score_sum = user.quotes.sum(:score)
  quote_count = user.quotes.length
  score = score_sum / quote_count

  positive_count = user.quotes.where("sentiment = 'positive'").count
  negative_count = user.quotes.where("sentiment = 'positive'").count
  neutral_count = user.quotes.where("sentiment = 'neutral'").count

  if score >= 0.25
    puts "Based on this sample of quotes, it would seem that #{user.name} is pretty positive!"
  elsif score < 0.24 && score > -0.24
    puts "Based on this sample of quotes, it would seem that #{user.name} is pretty neutral."
  else score <= -0.25
    puts "Based on this sample of quotes, it would seem that #{user.name} is pretty negative."
  end
  puts "#{user.name} has liked #{positive_count} positive quotes, #{negative_count} negative quotes, and #{neutral_count} neutral quotes."
  menu
end

# logs out user after session
def logout
  current_user = User.find_by(logged_in: true)
  current_user.logged_in = false
  current_user.save
end

# path = '../images/james_baldwin.png'
#
Rothko::Drawing.new("../images/haruki_murakami.png", 284)

# welcome
# menu
# quiz
# logout
