$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'mscfiddle'

run MscFiddle::WebApp.new(ENV.fetch('DOC_ROOT', File.expand_path('doc')))
