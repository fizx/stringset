require "rubygems"
require 'spec'
require "benchmark"

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'stringset'

Spec::Runner.configure do |config|
  
end
