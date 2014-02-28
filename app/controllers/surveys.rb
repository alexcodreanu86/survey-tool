
get "/surveys/participant/:survey_id" do
  @survey = Survey.find(params[:survey_id])
  erb :"survey_views/show"
end


get "/surveys/edit/:survey_id" do
  @survey = Survey.find(params[:survey_id])
  if session[:user_id] == @survey.user_id
    erb :"survey_views/edit"
  else
    redirect to('/')  #user errors
  end
end

get '/surveys/delete/:survey_id' do
  @survey = Survey.find( )
  @survey.destroy
  redirect to('/')
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

post '/surveys/edit' do
  @survey = Survey.find(params[:survey_id])
  if session[:user_id] == @survey.user_id
    @survey.update_attributes(params[:survey])
    redirect to("/surveys/edit/#{@survey.id}")
  else
    redirect to('/')  #user errors
  end
end
