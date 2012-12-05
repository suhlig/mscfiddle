require 'rack-livereload'

use Rack::LiveReload

# http://stackoverflow.com/a/3930606
@root = File.expand_path(File.dirname(__FILE__))

run Proc.new{ |env|
  path = Rack::Utils.unescape(env['PATH_INFO'])
  index_file = @root + "#{path}/index.html"

  if File.exists?(index_file)
    [200, {'Content-Type' => 'text/html'}, File.read(index_file)]
  else
    Rack::Directory.new(@root).call(env)
  end
}