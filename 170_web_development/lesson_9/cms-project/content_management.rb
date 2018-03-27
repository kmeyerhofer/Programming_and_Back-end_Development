require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'redcarpet'

configure do
  enable :sessions
  set :session_secret, 'super secret'
end

helpers do
  def only_files_with_names(&block)
    files = Dir.new('data/')
    files.each { |file| yield file unless file == '.' || file == '..' }
  end
end

def render_markdown(text)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  markdown.render(text)
end

def load_file_content(path)
  content = File.read(path)
  case File.extname(path)
  when '.txt'
    headers['Content-Type'] = 'text/plain'
    content
  when '.md'
    render_markdown(content)
  end
end

get '/' do
  erb :docs
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

get '/:file_name' do
  name = params[:file_name]

  if File.exist?(file(name))
    load_file_content(file(name))
  else
    session[:message] = "#{params[:file_name]} does not exist."
    redirect '/'
  end
end

get '/:file_name/edit' do
  @contents = File.read(file(params[:file_name]))
  erb :edit
end

post '/:file_name/edit' do
  file_text = params[:new_text]
  File.write(file(params[:file_name]), file_text)
  session[:message] = "#{params[:file_name]} has been updated."
  redirect '/'
end
