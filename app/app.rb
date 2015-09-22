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
    @link = Link.create(url: params[:url], title: params[:title])
    redirect to('/links')
  end


  get '/links/new' do
    erb :'links/new'
  end
end
