post '/responses/new/:question_id' do
  response = Response.new({
    user_id: current_user.id,
    question_id: params[:question_id],
    content: params[:content]
    })
  if new_object.save
    redirect to("/responses_views/show")
  else
    @errors = response.errors.messages
    erb :"responses_views/new"
  end
end
