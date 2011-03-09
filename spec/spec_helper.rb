$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rspec'

require 'mm-paranoid'

MongoMapper.database = 'mm-paranoid-spec'

class ParanoidItem
  include MongoMapper::Document

  plugin MongoMapper::Plugins::Paranoid

  key :title, String
end

class NormalItem
  include MongoMapper::Document

  key :title, String
end

RSpec.configure do |config|
  config.before(:each) do
    ParanoidItem.delete_all
    NormalItem.delete_all
  end
end
