ENV["RACK_ENV"] = 'test'

require "minitest/autorun"
require 'rack/test'
require 'fileutils'

require_relative '../content_management'

class CMSTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    FileUtils.mkdir_p(data_path)
  end

  def create_document(name, content = '')
    File.open(File.join(data_path, name), "w") do |new_file|
      new_file.write(content)
    end
  end

  def session
    last_request.env['rack.session']
  end

  def teardown
    FileUtils.rm_r(data_path)
  end

  def admin_session
    { 'rack.session' => { username: 'admin' } }
  end

  def test_content_management
    create_document 'about.md', 'about text information'
    create_document 'changes.txt', 'about change text info'

    get '/'
    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, "about.md"
    assert_includes last_response.body, "changes.txt"
  end

  def test_viewing_text_document
    create_document 'history.txt', 'Ruby 0.95 released'
    get "/history.txt", {}, admin_session

    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response["Content-Type"]
    assert_includes last_response.body, "Ruby 0.95 released"
  end

  def test_document_not_found
    get '/notafile.ext', {}, admin_session

    assert_equal 302, last_response.status
    assert_equal 'notafile.ext does not exist.', session[:message]
  end

  def test_markdown
    create_document 'about.md', '#Ruby is...'
    get '/about.md', {}, admin_session
    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, '<h1>Ruby is...</h1>'
  end

  def test_editing_files
    create_document 'changes.txt', "<textarea <button type=\"submit\""
    get '/changes.txt/edit', {}, admin_session
    assert_equal 200, last_response.status
    assert_includes last_response.body, '<textarea'
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_editing_document_signed_out
    create_document 'changes.txt'
    get '/changes.txt/edit'
    assert_equal 302, last_response.status
    assert_equal 'You must be signed in to do that.', session[:message]
  end

  def test_updating_document
    post '/changes.txt/edit', {new_text: "new content, test edited"}, admin_session

    assert_equal 302, last_response.status
    assert_equal "changes.txt has been updated.", session[:message]

    get '/changes.txt'
    assert_equal 200, last_response.status
    assert_includes last_response.body, "new content, test edited"
  end

  def test_new_document_page
    create_document 'test1.txt', 'here is the test text'
    get '/new', {}, admin_session
    assert_equal 200, last_response.status
    assert_includes last_response.body, '<input'
    assert_includes last_response.body, "Enter a new document name:</label>"
  end

  def test_creation_of_new_document
    post '/new', {new_document: 'new_file.txt'}, admin_session
    assert_equal 302, last_response.status
    assert_equal 'new_file.txt has been created.', session[:message]

    get '/'
    assert_equal 200, last_response.status
    assert_includes last_response.body, "new_file.txt"
  end

  def test_create_invalid_document_empty
    post '/new', {new_document: ''}, admin_session
    assert_equal 422, last_response.status
    assert_includes last_response.body, "Document name is empty, please enter a file name."
  end

  def test_create_invalid_document_no_file_ending
    post '/new', {new_document: 'test'}, admin_session
    assert_equal 422, last_response.status
    assert_includes last_response.body, "test is an incorrect file name."
  end

  def test_deleting_document
    create_document('test.txt')
    post "/test.txt/delete", {}, admin_session
    assert_equal 302, last_response.status
    assert_equal 'test.txt was deleted.', session[:message]

    get '/'
    refute_includes last_response.body, %q(href='/test.txt')
  end

  def test_signin_form
    get '/users/signin'
    assert_equal 200, last_response.status
    assert_includes last_response.body, "<input"
    assert_includes last_response.body, %q(<button type='submit')
  end

  def test_signin
    post '/users/signin', username: 'admin', password: 'secret'
    assert_equal 302, last_response.status
    assert_equal 'Welcome!', session[:message]
    assert_equal 'admin', session[:username]
  end

  def test_signin_with_bad_credentials
    post 'users/signin', username: 'guest', password: 'shhhh'
    assert_equal 422, last_response.status
    assert_nil session[:username]
    assert_includes last_response.body, 'Invalid credentials'
  end

  def test_signout
    get '/', {}, {'rack.session' => { username: 'admin' } }
    assert_includes last_response.body, 'Signed in as admin'

    post '/users/signout'
    get last_response['Location']

    assert_includes last_response.body, 'You have been signed out'
    assert_includes last_response.body, 'Sign In'
  end

  def test_deleting_document
    create_document('test.txt', 'testing text')
    post '/test.txt/delete', {}, admin_session
    assert_equal 302, last_response.status
    assert_equal 'test.txt was deleted.', session[:message]
    get '/'
    refute_includes last_response.body, %q(href='/test.txt')
  end

  def test_deleting_document_signed_out
    create_document('test.txt')
    post '/test.txt/delete'
    assert_equal 302, last_response.status
    assert_equal "You must be signed in to do that.", session[:message]
  end

  def test_login_of_other_user
    post '/users/signin', username: 'mary', password: 'sue'
    assert_equal 302, last_response.status
    assert_equal 'Welcome!', session[:message]
    assert_equal 'mary', session[:username]
  end
end
