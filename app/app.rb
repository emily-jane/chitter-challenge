require_relative '../data_mapper_setup'
require_relative './models/peep'
require_relative './models/user'
require 'sinatra/base'
require 'sinatra/flash'

class Chitter < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  register Sinatra::Flash

  helpers do
    def current_user
      current_user ||= User.get(session[:user_id])
    end
  end

  get '/peeps' do
    @peeps = Peep.all
    erb :'peeps/index'
  end

  post '/peeps' do
    timestamp = Time.now
    Peep.create(text: params[:text], timestamp: timestamp)
    redirect to '/peeps'
  end

  get '/peeps/new' do
    erb :'peeps/new'
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email],
                password: params[:password],
                name: params[:name],
                username: params[:username],
                password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/peeps'
    else
      flash.now[:notice] = "Password and confirmation password do not match"
      erb :'users/new'
    end
  end
end