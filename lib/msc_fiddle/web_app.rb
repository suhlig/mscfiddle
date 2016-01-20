require 'sinatra/base'
require 'tilt/erb'
require 'rack-livereload'

module MscFiddle
  class WebApp < Sinatra::Base
    set :views, 'views'
    use Rack::LiveReload

    # http://stackoverflow.com/a/3930606
    def initialize(doc_root = nil)
      super
      @doc_root = doc_root || File.expand_path('.')
    end

    get '/' do
      Dir.entries(@doc_root).select do |f|
        '.msc' == File.extname(f)
      end.map do |f|
        bn = File.basename(f, '.msc')
        "<a href='#{bn}'>#{bn}</a><br>"
      end
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
      path = params[:splat].first

      @img = "#{path}.svg"
      @src = "#{path}.msc"

      if File.exists?(File.join(@doc_root, @img))
        erb :'image.html'
      else
        halt 404, 'Not found'
      end
    end
  end
end
