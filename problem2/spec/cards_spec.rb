require_relative '../solver'
require 'debugger'
RSpec.configure do |config|
  config.mock_framework = :mocha
end

describe Cards do

  before(:each) do
    @generation = [9, 10, 21, 20, 7, 11, 4, 15, 7, 7, 14, 5, 20, 6, 29, 8, 11, 19, 18, 22, 29, 14, 27, 17, 6, 22, 12, 18, 18, 30]
    @overhead = [21, 16, 19, 26, 26, 7, 1, 8, 17, 14, 15, 25, 20, 3, 24, 5, 28, 9, 2, 14, 9, 25, 15, 13, 15, 9, 6, 20, 27, 22]
    @budget = 2912
  end

  it "transform" do
    g = [9, 10]
    o = [21, 16]
    cards = Cards.new(g,o)
    cards.
  end

end