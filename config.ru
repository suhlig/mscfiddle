require 'erb'
require 'rack-livereload'

use Rack::LiveReload

# http://stackoverflow.com/a/3930606
root = File.expand_path('.')

run Proc.new{|env|
  path = Rack::Utils.unescape(env['PATH_INFO'])
  @img = "#{path}.svg"
  @src = "#{path}.msc"

  if !File.exists?(File.join(root, @img))
    Rack::Directory.new(root).call(env)
  else
    wrapped = ERB.new(File.read(File.join(root, "image.html.erb"))).result(binding)
    [200, {'Content-Type' => 'text/html', }, [wrapped]]
  end
}
