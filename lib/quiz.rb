# mood quiz method
def quiz

# loops for the length of half of all the quotes allowing the user to choose between one of two quotes
  prompt = TTY::Prompt.new(active_color: :cyan)
  i = 0
  while i < (Quote.all.length / 2)
    answer = prompt.select('Which quote?') do |menu|
      menu.choice name: Quote.all[i].content
      menu.choice name: Quote.all[i+1].content
    end

# creates new instance of liked class
    new_liked = Liked.new

# assigns user_id column of new liked instance to the id of the currently logged in user
    new_liked.user_id = User.find_by(logged_in: true).id

# assigns the quote_id column of the new liked instance to the id of the quote matched on content
    new_liked.quote_id = Quote.find_by(content: answer).id

# saves new instance of liked
    new_liked.save

# iterator must increment by 2 because we are going through two quotes at a time
    i += 2
  end

# return to start menu
  menu
end
