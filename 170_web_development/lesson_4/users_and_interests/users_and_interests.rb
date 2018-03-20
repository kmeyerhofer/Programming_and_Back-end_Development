require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'yaml'

require 'pry'

helpers do
  def interests_format(user)
    @yml_data[user][:interests].join(', ')
  end

  def user_count
    @user_strings.count
  end

  def interest_count
    count = 0
    @yml_data.values.each { |interest| count += interest[:interests].count }
    count
  end

end

before do
  @user_strings = load_yml.keys
  @yml_data = load_yml
end

def load_yml
  YAML.load_file('data/users.yaml')
end

get '/' do
  redirect '/user-list'
end

get '/user-list' do
  @title = 'Users'
  erb :users
end

get '/user/:username' do
  @current_user = params[:username].to_sym
  @title = @current_user
  @other_users = @user_strings.dup
  @other_users.delete(@current_user)
  erb :user
end
