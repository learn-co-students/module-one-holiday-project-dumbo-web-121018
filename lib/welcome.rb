# Welcomes new or returning user to game
def welcome
  a = Artii::Base.new :font => 'epic'
  puts Rainbow(a.asciify('...MOOD QUIZ...')).purple
  prompt = TTY::Prompt.new
  username = prompt.ask('What is your name?')
  if User.find_by(name: username) == nil
    city = prompt.ask('What is your city name?')
    new_user = User.new
    new_user.name = username
    new_user.city = city
    new_user.save
    puts "Welcome #{username}"
  else
    puts "Welcome back #{username}"
  end
  current_user = User.find_by(name: username)
  current_user.logged_in = true
  current_user.save
end
