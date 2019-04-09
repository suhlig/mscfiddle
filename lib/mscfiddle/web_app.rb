require 'sinatra/base'
require 'tilt/erb'
require 'digest'
require 'json'
require 'mscfiddle/msc_gen'

module MscFiddle
  class WebApp < Sinatra::Base
    IMAGES = {
      empty: '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
      <svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 500 500" width="500" height="500" />',
    }

    set :views, 'views'

    get '/' do
      erb :fiddle
    end

    post '/' do
      msc = request.body.read
      @sha = Digest::SHA256.hexdigest(msc)
      @svg = MscGen.new(msc).to_svg
      IMAGES[@sha] = @svg

      content_type 'application/javascript'
      erb :'render.js', layout: false
    rescue
      @error = $!.message
      erb :'error.js', layout: false
    end

    get '/empty.svg' do
      content_type 'image/svg+xml'
      IMAGES.fetch(:empty)
    end

    get %r|/([A-Fa-f0-9]{64})\.svg| do |sha|
      content_type 'image/svg+xml'
      IMAGES.fetch(sha, :empty)
    end
  end
end
