require 'pry'
require 'sinatra'
# require 'sinatra/reloader'
require_relative 'db_config'
require 'httparty'
require 'bcrypt'

require_relative 'models/log'
require_relative 'models/user'
require_relative 'models/like'

enable :sessions

helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

end

after do
  ActiveRecord::Base.connection.close
end


get '/' do
  @image = HTTParty.get("https://api.nasa.gov/planetary/apod?api_key=iv8865vntcS0LWY5t7T4On46KorDgvVQbPvU8ulu")
  erb :index
end

get '/logs' do
  @logs = Log.all
  erb :logs
end

get '/logs/new' do
  redirect '/login' unless logged_in?
  erb :new
end

post '/logs' do
  log = Log.new
  log.submit_date = Time.now
  log.user_id = current_user.id
  log.experience_name = params[:name]
  log.gender = params[:gender]
  log.age = params[:age]
  log.body_weight = params[:body_weight]
  log.drug = params[:drug]
  log.dosage = params[:dosage]
  log.purity = params[:purity]
  log.prior_experience = params[:prior_experience]
  log.substance_consumption = params[:substance_consumption]
  log.food = params[:food]
  log.hydration = params[:hydration]
  log.weather = params[:weather]
  log.temprature = params[:temprature]
  log.environment = params[:environment]
  log.group_environment = params[:group_environment]
  log.mood_before = params[:mood_before]
  log.intensity = params[:intensity]
  log.visuals = params[:visuals]
  log.euphoria = params[:euphoria]
  log.fear = params[:fear]
  log.revelations = params[:revelations]
  log.experience = params[:experience]
  log.user_recommendation = params[:user_recommendation]
  log.notes = params[:notes]
  log.save
  redirect '/logs'
end

get '/logs/:id' do
  @log = Log.find(params[:id])
  @likes = Like.where(log_id: @log.id)
  erb :log_details
end

post '/likes' do
  already_liked = Like.where(log_id: params[:log_id], user: current_user).any?
  if already_liked
    redirect "/logs/#{params[:log_id]}"
  else
    like = Like.new
    like.log_id = params[:log_id]
    like.user_id = current_user.id
    like.save
    redirect "/logs/#{params[:log_id]}"
  end 
end

get '/login' do
  erb :login
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  if User.find_by(email: params[:email])
    erb :login
  else
    user = User.new
    user.email = params[:email]
    user.password = params[:password]
    user.save
    redirect '/logs/new'
  end
end

post '/session' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    erb :notfound
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/'
end

get '/mylogs' do
  @myLogs = Log.where(user_id: current_user.id)
  if @myLogs.any?
    erb :mylogs
  end
end

get "/search" do
  @search = Log.where("experience_name ilike '%#{params[:search]}%'")
  if @search.any?
    erb :search
  end
end