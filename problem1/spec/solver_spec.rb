require_relative '../solver'
RSpec.configure do |config|
  config.mock_framework = :mocha
end

describe Solver do
  it "permute_solutions" do
    map = mock()
    solver = Solver.new(map)
    solver.stubs(:solutions => [7,9,5])
    solver.stubs(:n_choose_k).returns(2520, 15120, 120)
    solver.permute_solutions.should eq(17760)
  end

  it "check_rows" do
    map = Map.new
    map.stubs(:matrix => [[0,0,0,0,0], [0,1,0,0,0,0,0], [1,1,1]])
    map.stubs(:number_of_empty_spots_in_a_row).returns(5,6,0)
    solver = Solver.new(map)
    solver.check_rows
    solver.solutions.should eq([5,6])
  end

  it "check_columns" do
   map = Map.new
   array = []
   5.times {|i| array << [0]}
   map.stubs(:matrix => array)
   solver = Solver.new(map)
   solver.check_columns
   solver.solutions.should eq([5]) 
  end

  it "factorial" do
    map = Map.new
    solver = Solver.new(map)
    solver.factorial(5).should eq(120)
  end

  it "n_choose_k" do
    map = Map.new
    solver = Solver.new(map)
    solver.n_choose_k(7,5).should eq(2520)
  end

end