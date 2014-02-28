get "/surveys/participate/:survey_id" do
  if session[:user_id]
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions
    erb :"survey_views/show"
  else
    redirect to('/')
  end 
end


get "/surveys/edit/:survey_id" do
  @survey = Survey.find(params[:survey_id])
  @questions = @survey.questions
  if session[:user_id] == @survey.user_id
    erb :"survey_views/edit"
  else
    redirect to('/')  #user errors
  end
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


post '/surveys/new' do
  @survey = Survey.new(user_id: session[:user_id], title: "Title", category: params[:category])
  if @survey.save
    redirect to("/surveys/edit/#{@survey.id}")
  else
    @errors = @survey.errors.messages
    erb :"surveys_views/new"
  end
end

post '/surveys/submit/:survey_id' do
  Participation.create(user_id: session[:user_id], survey_id: params[:survey_id])
  params[:survey].each do |quest_id, answer|
    Response.create(user_id: session[:user_id], question_id: quest_id, content: answer)
  end
  redirect to('/')
end

post '/surveys/edit' do
  @survey = Survey.find(params[:survey_id])
  if session[:user_id] == @survey.user_id
    @survey.update_attributes(params[:survey])
    redirect to("/surveys/edit/#{@survey.id}")
  else
    redirect to('/')  #user errors
  end
end
