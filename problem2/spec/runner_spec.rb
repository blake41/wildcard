require_relative '../solver'
require 'debugger'
RSpec.configure do |config|
  config.mock_framework = :mocha
end

describe Solver do

  before(:each) do
    @generation = [9, 10, 21, 20, 7, 11, 4, 15, 7, 7, 14, 5, 20, 6, 29, 8, 11, 19, 18, 22, 29, 14, 27, 17, 6, 22, 12, 18, 18, 30]
    @overhead = [21, 16, 19, 26, 26, 7, 1, 8, 17, 14, 15, 25, 20, 3, 24, 5, 28, 9, 2, 14, 9, 25, 15, 13, 15, 9, 6, 20, 27, 22]
    @budget = 2912
  end

  let(:solver) {Solver.new(@generation, @overhead, @budget)}

  it "calculate_time" do
    solver.calculate_time(2, 9, 21).should eq(51)
  end

  it "sum_generations" do
    solver.sum_generations(0).should eq(9)
    solver.sum_generations(1).should eq(56)
    solver.sum_generations(2).should eq(152)
  end

  it "solve" do  
    solver.stubs(:generation => [9,10], :overhead => [21,16])
    solver.stubs(:sum_generations).returns(30,93)
    solver.find_solutions.should eq({1 => 30, 2 => 93})
  end

  it "solve should not add solutions whose total time exceeds budget" do
    solver.stubs(:generation => [9,10], :overhead => [21,16])
    solver.stubs(:sum_generations).returns(30,3000)
    solver.find_solutions.should eq({1 => 30})
  end
  
  it "should return the largest solution" do
    solutions = {1 => 30, 2 => 93}
    solver.get_answer(solutions).should eq({2 => 93}) 
  end

end