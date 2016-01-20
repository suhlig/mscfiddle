require 'erb'
require 'rack-livereload'

use Rack::LiveReload

# http://stackoverflow.com/a/3930606
def root
  File.expand_path('.')
end

def msc_files
  Dir.entries(root).select do |f|
    '.msc' == File.extname(f)
  end.map do |f|
    bn = File.basename(f, '.msc')
    "<a href='#{bn}'>#{bn}</a><br>"
  end
end

run Proc.new{|env|
  path = Rack::Utils.unescape(env['PATH_INFO'])

  if '/' == path
    [200, {'Content-Type' => 'text/html', }, msc_files]
  else
    file = File.join(root, path)

    if File.exists?(file)
      case File.extname(file)
        when '.svg'
          [200, {'Content-Type' => 'image/svg+xml', }, File.read(file)]
        when '.msc'
          [200, {'Content-Type' => 'text/plain', }, File.read(file)]
        else
          [403, {'Content-Type' => 'text/plain', }, "Not willing to serve #{file}."]
      end
    else
      img = "#{path}.svg"
      src = "#{path}.msc"

      if !File.exists?(File.join(root, img))
        [404, {'Content-Type' => 'text/plain', }, "Could not find #{file}."]
      else
        wrapped = ERB.new(File.read(File.join(root, "image.html.erb"))).result(binding)
        [200, {'Content-Type' => 'text/html', }, [wrapped]]
      end
    end
  end
}
