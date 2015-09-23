require 'sinatra/base'
require 'data_mapper'
require './app/data_mapper_setup'


class BookManager < Sinatra::Base
  run! if app_file == $PROGRAM_NAME
  enable :sessions
  set :session_secret, 'super secret'
  set :views, proc { File.join(root, 'views') }

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    tag_name = params[:tags].split(" ")
    tag_name.each do |name|
      link.tags << Tag.create(name: name)
      link.save
    end
    redirect to('/links')
  end

  get '/links/new' do
    erb :'links/new'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email],
    email_confirmation: params[:email_confirmation],
    password: params[:password],
    password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    redirect '/users'
  end

  get '/users' do
    erb :name
  end

  helpers do
    def current_user
        User.get(session[:user_id])
    end
  end

end
