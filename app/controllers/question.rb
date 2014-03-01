get '/question/new_text/:survey_id' do
  if request.xhr?
    erb :"question_views/forms/_text_question", layout: false
  else
    @text = true
  	erb :"question_views/new"
  end
end

get "/question/new_multi/:survey_id" do
  if request.xhr?
    erb :"question_views/forms/_multi_question", layout: false
  else
    @multi = true
    erb :"question_views/new"
  end
end

get "/question/add_option/:question_id" do
  @question = Question.find(params[:question_id])
  erb :"question_views/add_options" 
end

# get '/question/edit/:question_id' do
#   edit_object = Question.find(params[:question_id])
#   edit_object.update_attributes(params)
#   redirect to('/')
# end



post '/question/new_text/:survey_id' do 
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

post "/question/add_option/:question_id" do
  @option = Option.new(question_id: params[:question_id], content: params[:content])
  if @option.save
    redirect to "/question/add_option/#{params[:question_id]}"
  else
    @question = Question.find(params[:question_id])
    @errors = @option.errors.messages
    erb :"question_views/add_options"
  end
end


post '/question/new_multi/:survey_id' do 
  @q = Question.new({
    variety: "multi",
    survey_id: params[:survey_id],
    prompt: params[:question][:prompt]
    })
  if @q.save
    if request.xhr?
      return @q.to_json
    else
      redirect to("/question/add_option/#{@q.id}")
    end
  else
    @errors = @q.errors.messages
    erb :"question_views/new"
  end
end

post '/question/delete/:question_id' do
   question = Question.find(params[:question_id])
   question.destroy

   redirect to '/'
end