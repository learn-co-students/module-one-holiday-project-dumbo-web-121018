def user_score_by_date

  user = User.all.find_by(logged_in: true)
  dates = user.likeds.map do |like|
    like.created_at.strftime("%B %d, %Y")
  end.uniq

  prompt = TTY::Prompt.new
  select = prompt.select('Which date?') do |menu|
    dates.each do |date|
      menu.choice date
    end
  end

  likes_that_day = user.likeds.select do |like|
    like.created_at.strftime("%B %d, %Y") == select
  end

  score_sum = 0
  magnitude_sum = 0
  likes_that_day.each do |like|
    score_sum += like.quote.score
    magnitude_sum += like.quote.magnitude
  end
  score = score_sum / likes_that_day.count
  magnitude = magnitude_sum / likes_that_day.count

  if score > 0.5 && magnitude > 0.5
    puts "Based on this sample of quotes, it would seem that #{user.name} was very positive that day!"
  elsif score > 0.1 && magnitude > 0.2
    puts "Based on this sample of quotes, it would seem that #{user.name} was somewhat positive that day."
  elsif score < 0 && magnitude > 0.5
    puts "Based on this sample of quotes, it would seem that #{user.name} was very negative that day."
  elsif score < 0 && magnitude > 0.2
    puts "Based on this sample of quotes, it would seem that #{user.name} was somewhat negative that day."
  elsif (0..0.19).include?(magnitude)
    puts "Based on this samle of quotes, it would seem that #{user.name} was pretty neutral that day."
  else (0...0.1).include?(score) && magnitude > 0.2
    puts "Based on this samle of quotes, it would seem that #{user.name} was a mixed bag that day!"
  end
  puts "Score: #{score}"
  puts "Magnitude: #{magnitude}"

  menu
end
