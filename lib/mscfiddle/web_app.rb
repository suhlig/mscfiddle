require 'sinatra/base'
require 'tilt/erb'
require 'rack-livereload'
require 'sinatra/partial'

module MscFiddle
  class WebApp < Sinatra::Base
    set :views, 'views'
    use Rack::LiveReload

    register Sinatra::Partial
    set :partial_template_engine, :erb
    enable :partial_underscores

    # http://stackoverflow.com/a/3930606
    def initialize(doc_root = nil)
      super
      @doc_root = doc_root || File.expand_path('.')
    end

    get '/' do
      @charts = Dir.entries(@doc_root).select do |f|
        '.msc' == File.extname(f)
      end.map do |f|
        File.basename(f, '.msc')
      end
      erb :index
    end

    get %r{/(.+\.svg)} do |file|
      content_type 'image/svg+xml'
      File.read(File.join(@doc_root, file))
    end

    get %r{/(.+\.msc)} do |file|
      content_type 'text/plain'
      File.read(File.join(@doc_root, file))
    end

    get '/*' do
      @title = params[:splat].first
      @img = "#{@title}.svg"
      @src = "#{@title}.msc"

      if File.exists?(File.join(@doc_root, @img))
        erb :image
      else
        halt 404, 'Not found'
      end
    end
  end
end
