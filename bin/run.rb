require_relative '../config/environment'
require 'artii'




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


welcome

binding.pry
