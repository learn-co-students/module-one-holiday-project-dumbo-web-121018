require_relative '../config/environment'
# require 'artii'
# require 'tty-prompt'



def welcome
  a = Artii::Base.new
  puts a.asciify('Mood Quiz!!!')
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
  current_user = User.find_by(name: 'Wiljago')
  current_user.logged_in = true
  current_user.save
end

def positive_quotes
  Quote.all.select do |quote|
    quote.score > 0.05
  end

end

def negative_quotes
  Quote.all.select do |quote|
    quote.score < 0.05
  end
end

def display_quotes
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
end

def author_score(name)
  score_sum = Author.all.find_by(name: name).quotes.sum(:score)
  quote_count = Author.all.find_by(name: name).quotes.length
  score = score_sum / quote_count
  if score >= 0.25
    puts "Based on this sample of quotes, it would seem that #{name} is pretty positive!"
  elsif score < 0.25 && score > -0.25
    puts "Based on this sample of quotes, it would seem that #{name} is pretty neutral."
  else score <= -0.25
    puts "Based on this sample of quotes, it would seem that #{name} is pretty negative."
  end
end

author_score("Jane Austen")
# welcome
# display_quotes
