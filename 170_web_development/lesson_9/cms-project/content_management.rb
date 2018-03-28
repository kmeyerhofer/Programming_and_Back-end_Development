require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'redcarpet'
require 'yaml'
require 'bcrypt'

configure do
  enable :sessions
  set :session_secret, 'super secret'
end

helpers do
  def only_files_with_names(&block)
    files = Dir.new(data_path)
    files.each { |file| yield file unless file == '.' || file == '..' }
  end
end

def valid_credentials?(username, password)
  credentials = load_users
  if credentials.key?(username)
    bcrypt_password = BCrypt::Password.new(credentials[username])
    bcrypt_password == password
  else
    false
  end
end

def load_users
  file_path = if ENV["RACK_ENV"] == 'test'
    File.expand_path('../test/users.yml', __FILE__)
  else
    File.expand_path('../users.yml', __FILE__)
  end
  YAML.load_file(file_path)
end

def user_signed_in?
  session.key?(:username)
end

def require_signed_in_user
  unless user_signed_in?
    session[:message] = 'You must be signed in to do that.'
    redirect '/'
  end
end

def render_markdown(text)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  markdown.render(text)
end

def load_file_content(path)
  content = File.read(path)
  if File.extname(path) == '.md'
    erb render_markdown(content)
  else
    headers['Content-Type'] = 'text/plain'
    content
  end
end

def data_path
  if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/data", __FILE__)
  else
    File.expand_path("../data", __FILE__)
  end
end

def file(name)
  File.join(data_path, name)
end

get '/' do
  erb :docs, layout: :layout
end

post '/:file_name/delete' do
  require_signed_in_user
  filename = params[:file_name].to_s
  if File.exist?(file(filename))
    File.delete(file(filename))
    session[:message] = "#{filename} was deleted."
    redirect '/'
  else
    session[:message] = 'File does not exist.'
    redirect '/'
  end
end

get '/new' do
  require_signed_in_user
  erb :new
end

post '/new' do
  require_signed_in_user
  filename = params[:new_document].to_s.strip
  if filename.size == 0
    session[:message] = "Document name is empty, please enter a file name."
    status 422
    erb :new
  elsif filename.match?(/\w+[.]\w+/)
    new_file = File.new(file(filename), File::CREAT)
    session[:message] = "#{filename} has been created."
    redirect '/'
  else
    session[:message] = "#{filename} is an incorrect file name."
    status 422
    erb :new
  end
end

get '/:file_name' do
  require_signed_in_user
  name = params[:file_name]

  if File.exist?(file(name))
    load_file_content(file(name))
  else
    session[:message] = "#{params[:file_name]} does not exist."
    redirect '/'
  end
end

get '/:file_name/edit' do
  require_signed_in_user
  @contents = File.read(file(params[:file_name]))
  erb :edit
end

post '/:file_name/edit' do
  require_signed_in_user
  file_text = params[:new_text]
  File.write(file(params[:file_name]), file_text)
  session[:message] = "#{params[:file_name]} has been updated."
  redirect '/'
end

get '/users/signin' do
  erb :signin
end

post '/users/signin' do
  username = params[:username]
  if valid_credentials?(username, params[:password])
    session[:username] = params[:username]
    session[:message] = 'Welcome!'
    redirect '/'
  else
    session[:message] = 'Invalid credentials'
    status 422
    erb :signin
  end
end

post '/users/signout' do
  session.delete(:username)
  session[:message] = 'You have been signed out.'
  redirect '/'
end
