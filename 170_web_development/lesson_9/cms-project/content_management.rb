require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

root = File.expand_path('..', __FILE__)

helpers do
  def only_files_with_names(&block)
    files = Dir.new('data/')
    files.each { |file| yield file unless file == '.' || file == '..' }
  end
end

get '/' do
  erb :docs
end

get '/:file_name' do
  filename = root + "/data/" + params[:file_name]
  headers["Content-Type"] = "text/plain"
  File.read(filename)
end
