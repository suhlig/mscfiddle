require_relative '../helper'
require 'rack/test'

class TestApp < Minitest::Test
  include Rack::Test::Methods

  def app
    MscFiddle::WebApp.new(File.join(__dir__, '..', '..', 'doc'))
  end

  def test_index
    get '/'

    assert(last_response.ok?)
    assert_equal('text/html;charset=utf-8', last_response.content_type)

    body = last_response.body
    refute(body.empty?)
  end

  def test_wrapper
    get '/livereload'

    assert(last_response.ok?)
    assert_equal('text/html;charset=utf-8', last_response.content_type)

    body = last_response.body
    refute(body.empty?)
  end

  def test_msc
    get '/livereload.msc'

    assert(last_response.ok?)
    assert_equal('text/plain;charset=utf-8', last_response.content_type)

    body = last_response.body
    refute(body.empty?)
  end

  def test_svg
    get '/livereload.svg'

    assert(last_response.ok?)
    assert_equal('image/svg+xml', last_response.content_type)

    body = last_response.body
    refute(body.empty?)
  end

  def test_not_existing
    get '/livereload.bmp'
    assert_equal(404, last_response.status)
    assert_equal('text/html;charset=utf-8', last_response.content_type)

    body = last_response.body
    refute(body.empty?)
  end
end
