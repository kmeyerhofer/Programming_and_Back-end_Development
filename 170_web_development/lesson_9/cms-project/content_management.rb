require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

helpers do
  def only_files_with_names(&block)
    files = Dir.new('data/')
    files.each { |file| yield file unless file == '.' || file == '..' }
  end
end

get '/' do
  erb :docs
end
