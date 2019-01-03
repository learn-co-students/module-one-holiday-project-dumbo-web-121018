# options menu
def menu
  user = User.find_by(logged_in: true)
  prompt = TTY::Prompt.new
  select = prompt.select('What would you like to do?') do |menu|
    menu.choice "Take the quiz",  value: 1
    menu.choice "See author moods", value: 2
    menu.choice "See my overall mood", value: 3
    menu.choice "See my mood by date", value: 4
    menu.choice "Add quote", value: 5
    menu.choice "Logout", value: 6
  end
  if select[:value] == 1
    quiz
  elsif select[:value] == 2
    author_score
  elsif select[:value] == 3
    user_total_score
  elsif select[:value] == 4
    user_score_by_date
  elsif select[:value] == 5
    add_quote
  else
    logout
  end
end
