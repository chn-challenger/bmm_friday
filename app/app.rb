require 'sinatra/base'
require 'data_mapper'
require './app/data_mapper_setup'
require './app/helpers/current_user'

class BookManager < Sinatra::Base
  include CurrentUser

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
    #we just initialize the object
    #without saving it. It may be invalid
    user = User.create(email: params[:email],
    password: params[:password],
    password_confirmation: params[:password_confirmation])
    if user.save # #save return true or false depending on whther the
      #module is successfully saved to the database
      session[:user_id] = user.id
      redirect to '/links'
      #if it is not valid, we'll render the sign up form again
    else
      erb :'users/new'
    end
  end

end
