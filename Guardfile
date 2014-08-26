guard 'shell' do
  watch(/(.*).msc/) {|m| `mscgen -T svg -i #{m[0]}`}
end

guard 'livereload' do
  watch(%r{.+\.(svg|erb|html)$})
end

