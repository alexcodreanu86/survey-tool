def current_user?
  session[:user_id]
end

def current_user
  User.find(session[:user_id])
end

def has_taken_survey?(survey)
  !survey.participations.where(user_id: current_user?).empty?
end