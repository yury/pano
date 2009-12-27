$:.unshift File.expand_path(File.join(File.dirname(__FILE__)))
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require "pp"
require "rubygems"
require "spec"
require 'spec/autorun'