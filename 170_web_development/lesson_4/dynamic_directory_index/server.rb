require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get '/' do
  sort = params['sort']
  @link = 'descending'

  if sort == 'descending'
    @link = 'ascending'
    @files = Dir.entries('public/').sort { |a, b| b <=> a }
  elsif sort == 'ascending'
    @link = 'descending'
    @files = Dir.entries('public/').sort
  else
    @files = Dir.entries('public/').sort
  end

  erb :home
end

def sort_link
  case @link
  when 'ascending'
    '/?sort=ascending'
  when 'descending'
    '/?sort=descending'
  end
end
