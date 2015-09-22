require 'sinatra/base'

class BookManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end
end
