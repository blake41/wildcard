require_relative '../solver'

RSpec.configure do |config|
  config.mock_framework = :mocha
end

describe Map do

  it "number_of_empty_spots_in_a_row" do
    map = Map.new
    row = [0,0,1,0,1,0]
    map.number_of_empty_spots_in_a_row(row).should eq(4)
    
  end

end