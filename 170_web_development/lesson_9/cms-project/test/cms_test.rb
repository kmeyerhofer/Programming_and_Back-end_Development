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
    File.open(File.join(data_path, name), "w") do |file|
      file.write(content)
    end
  end

  def teardown
    FileUtils.rm_r(data_path)
  end

  def test_content_management
    create_document 'about.md'
    create_document 'changes.txt'

    get '/'
    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, "about.md"
    assert_includes last_response.body, "changes.txt"
  end

  def test_viewing_text_document
    create_document 'history.txt', 'Ruby 0.95 released'
    get "/history.txt"

    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response["Content-Type"]
    assert_includes last_response.body, "Ruby 0.95 released"
  end

  def test_document_not_found
    get '/notafile.ext'

    assert_equal 302, last_response.status

    get last_response['Location']
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'notafile.ext does not exist'
  end

  def test_markdown
    create_document 'about.md', '#Ruby is...'
    get '/about.md'
    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, '<h1>Ruby is...</h1>'
  end

  def test_editing_files
    create_document 'changes.txt', "<textarea <button type=\"submit\""
    get '/changes.txt/edit'
    assert_equal 200, last_response.status
    assert_includes last_response.body, '<textarea'
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_updating_document
    create_document 'changes.txt'
    post '/changes.txt/edit', new_text: "new content, test edited"

    assert_equal 302, last_response.status
    get last_response["Location"]
    assert_includes last_response.body, "changes.txt has been updated"
    get '/changes.txt'
    assert_equal 200, last_response.status
    assert_includes last_response.body, "new content, test edited"
  end

  def test_new_document_page
    create_document 'test1.txt', 'here is the test text'
    get '/new'
    assert_equal 200, last_response.status
    assert_includes last_response.body, '<input'
    assert_includes last_response.body, "Enter a new document name:</label>"
  end

  def test_creation_of_new_document
    post '/new', new_document: 'new_file.txt'
    assert_equal 302, last_response.status

    get '/'
    assert_equal 200, last_response.status
    assert_includes last_response.body, "new_file.txt"
  end

  def test_create_invalid_document_empty
    post '/new', filename: ''
    assert_equal 422, last_response.status
    assert_includes last_response.body, "Document name is empty, please enter a file name."
  end

  def test_create_invalid_document_no_file_ending
    post '/new', filename: 'test'
    assert_equal 422, last_response.status
    assert_includes last_response.body, "test is an incorrect file name."
  end
end
