guard 'livereload' do
  watch(%r{.+\.(rb|svg|erb|html)$})
end

guard 'minitest' do
  watch(%r|^test/unit/test_(.*)\.rb|)
  watch(%r|^lib/*\.rb|){'test'}
  watch(%r{^lib/.*/([^/]+)\.rb$}){|m| "test/unit/test_#{m[1]}.rb"}
  watch(%r|^test/helper\.rb|){'test'}
end

guard 'bundler' do
  require 'guard/bundler'
  watch(%r|Gemfile|)
end
