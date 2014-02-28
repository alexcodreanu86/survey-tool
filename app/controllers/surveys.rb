get "/surveys/participate/:survey_id" do
  redirect to "/" if !current_user?
  @survey = Survey.find(params[:survey_id])
  @questions = @survey.questions
  erb :"survey_views/show"
end

get "/surveys/edit/:survey_id" do
  @survey = Survey.find(params[:survey_id])
  redirect to "/" if !current_user? && current_user.id != @survey.user_id
  @questions = @survey.questions
  if session[:user_id] == @survey.user_id
    erb :"survey_views/edit"
  else
    redirect to('/')  #user errors
  end
end

get "/surveys/index" do
  redirect to "/" if !current_user?
  @surveys = Survey.all
  erb :"survey_views/index" 
end

get '/surveys/new' do
  redirect to "/" if !current_user?
  @survey = Survey.create(user_id: session[:user_id], title: "Title", category: params[:category])
  redirect to("/surveys/edit/#{@survey.id}")

end

post '/surveys/delete' do
  @survey = Survey.find(params[:survey_id])
  if session[:user_id] == @survey.user_id
    @survey.destroy
    redirect to("/user/#{session[:user_id]}")
  else 
    redirect to('/')
  end
end



post '/surveys/submit/:survey_id' do
  Participation.create(user_id: session[:user_id], survey_id: params[:survey_id])
  params[:survey].each do |quest_id, answer|
    Response.create(user_id: session[:user_id], question_id: quest_id, content: answer)
  end
  redirect to('/')
end

post '/surveys/edit/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  if session[:user_id] == @survey.user_id
    @survey.update_attributes(params[:survey])
    redirect to("/surveys/edit/#{@survey.id}")
  else
    redirect to('/')  #user errors
  end
end
