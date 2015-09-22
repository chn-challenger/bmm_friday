require 'sinatra/base'
# require File.join(File.dirname(__FILE__), 'models', 'link.rb')
# require 'data_mapper_setup'


class BookManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    @link = Link.create(url: params[:title], title: params[:url])
    redirect to('/links')
  end


  get '/links/new' do
    erb :'links/new'
  end
end
