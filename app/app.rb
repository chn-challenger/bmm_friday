require 'sinatra/base'
require 'data_mapper'
require './app/data_mapper_setup'


class BookManager < Sinatra::Base

  set :views, proc { File.join(root, 'views') }

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title]) #1.Create a Link

    tag = Tag.create(name: params[:tag]) #2. Create a tag for the Link

    link.tags << tag #3. Adding the tag to the link's DataMapper collection
    link.save #4. Saving the link

    redirect to('/links')
  end


  get '/links/new' do
    erb :'links/new'
  end
end
