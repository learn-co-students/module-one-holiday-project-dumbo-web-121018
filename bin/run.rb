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
  prompt = TTY::Prompt.new
  i = 0
  while i < positive_quotes.length
    prompt.select('Which quote?') do |menu|
      menu.choice name: positive_quotes[i].content,  value: 1
      menu.choice name: negative_quotes[i].content, value: 2
      i += 1
    end
    # binding.pry
  end
end


welcome
display_quotes
