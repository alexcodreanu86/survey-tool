# post '/participants/new' do
#   @ = Participants.new(params[participants])
#   if new_object.save
#     redirect to("/participants_views/all")
#   else
#     @errors = participants.errors.messages
#     erb :"participants_views/new"
#   end
# end

# get '/participants/edit' do
#   edit_object = Participants.find(params[:participants_id])
#   edit_object.update_attributes(params)
#   redirect to('/')
# end

# get '/participants/delete' do
#   participants = Participants.find( )
#   participants.destroy
#   redirect to('/')
# end
