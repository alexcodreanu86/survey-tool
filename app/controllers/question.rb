get '/question/new/:survey_id' do
	
	erb :"question_views/new"
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