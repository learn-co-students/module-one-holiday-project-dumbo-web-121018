# mood quiz method
def quiz
  prompt = TTY::Prompt.new(active_color: :cyan)
  i = 0
  while i < (Quote.all.length / 2)
    answer = prompt.select('Which quote?') do |menu|
      menu.choice name: Quote.all[i].content
      menu.choice name: Quote.all[i+1].content
    end
    new_liked = Liked.new
    new_liked.user_id = User.find_by(logged_in: true).id
    new_liked.quote_id = Quote.find_by(content: answer).id
    new_liked.save
    i += 2
  end
  menu
end
