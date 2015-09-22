require 'sinatra/base'
# require File.join(File.dirname(__FILE__), 'models', 'link.rb')

require './app/models/link'
require 'data_mapper'
require './app/data_mapper_setup'


class BookManager < Sinatra::Base
  set :views, proc { File.join(root, 'views') }
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
