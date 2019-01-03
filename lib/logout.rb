# logs out user after session
def logout
  current_user = User.find_by(logged_in: true)
  current_user.logged_in = false
  current_user.save
end
