get '/question/new/:survey_id' do
	
  if request.xhr?
    erb :"question_views/forms/_text_question", layout: false
  else
  	erb :"question_views/new"
  end
end

post '/question/new/:survey_id' do 
  q = Question.new({
  	survey_id: params[:survey_id],
  	prompt: params[:question][:prompt]
  	})
  if q.save
    redirect to('/')
  else
  	@errors = q.errors.messages
  	erb :"question_views/new"
  end
end

post '/question/delete/:question_id' do
   question = Question.find(question_id: params[:question_id])
   question.destroy

   redirect to '/'
end