$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'sapling'
require 'rspec'
require 'rspec/autorun'
require 'sapling_examples'

class UserMock
  def initialize(i=1)
    @id=i
  end
  def id;@id;end
end

RSpec.configure do |config|
  # config.mock_with :mocha
  config.before { }
end
