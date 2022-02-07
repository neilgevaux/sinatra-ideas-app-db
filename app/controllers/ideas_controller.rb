
%w(/ /ideas).each do |path|
    get path do
      @ideas = Idea.all
      erb :'ideas/index'
    end
  end

  %w(/new /ideas/new).each do |path|
    get path do
      @title = 'New Idea'
      @idea  = Idea.new
      erb :'ideas/new'
    end
  end

get '/ideas/:id' do
    @idea = Idea.find(params[:id])
    erb :'ideas/show'
end

# Create action
post '/ideas' do
    if params[:idea]
      @idea = Idea.new(params[:idea])
      if @idea.save
        redirect '/ideas'
      else
        erb :'ideas/new'
      end
    else
      erb :'ideas/new'
    end
  end


helpers do
    def delete_idea_button(idea_id)
      erb :'ideas/_delete_idea_button', locals: { idea_id: idea_id }
    end
end

# Delete action
delete '/ideas/:id' do
    Idea.find(params[:id]).destroy
    redirect '/ideas'
end

# Helper route for updating ideas
get '/ideas/:id/edit' do
    @idea = Idea.find(params[:id])
    erb :'ideas/edit'
end

# Update action
put '/ideas/:id' do

  @idea = Idea.find(params[:id])

  if @idea.update(params[:idea])
    if @filename

      @idea.save

    end
    redirect "/ideas/#{@idea.id}"
  else
    erb :'ideas/edit'
  end
end