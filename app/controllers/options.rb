# post '/options/new' do
#   new_object = Options.new(params[options])
#   if new_object.save
#     redirect to("/options_views/all")
#   else
#     @errors = options.errors.messages
#     erb :"options_views/new"
#   end
# end

# get '/options/edit' do
#   edit_object = Options.find(params[:options_id])
#   edit_object.update_attributes(params)
#   redirect to('/')
# end

# get '/options/delete' do
#   options = Options.find( )
#   options.destroy
#   redirect to('/')
# end
