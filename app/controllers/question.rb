get '/question/new/:survey_id' do
	
  if request.xhr?
    erb :"question_views/forms/_text_question", layout: false
  else
  	erb :"question_views/new"
  end
end

# get '/question/edit/:question_id' do
#   edit_object = Question.find(params[:question_id])
#   edit_object.update_attributes(params)
#   redirect to('/')
# end

post '/question/new/:survey_id' do 
  q = Question.new({
  	survey_id: params[:survey_id],
  	prompt: params[:question][:prompt]
  	})
  if q.save
    if request.xhr?
      return q.to_json
    else
      redirect to("/surveys/edit/#{params[:survey_id]}")
    end
  else
  	@errors = q.errors.messages
  	erb :"question_views/new"
  end
end

post '/question/delete/:question_id' do
   question = Question.find(params[:question_id])
   question.destroy

   redirect to '/'
end