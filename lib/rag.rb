$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Rag
  VERSION = '0.0.1'
end

require 'rag/aggregate'
require 'rag/aggregator'
require 'rag/array'