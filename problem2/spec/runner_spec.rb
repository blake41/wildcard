require_relative '../solver'

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

  it "should return the largest solution" do
    solutions = {1 => 30, 2 => 93}
    solver.highest_number_of_cards_in_solutions(solutions).should eq(2) 
  end

  it "transform" do
    g = [9, 10]
    o = [21, 16]
    card1 = Card.new(9,21)
    card2 = Card.new(10,16)
    solver.stubs(:generation => [9,10], :overhead => [21,16])
    solver.stubs(:create_card).returns(card1, card2)
    solver.transform.should eq([card1, card2])
  end

  it "calculate_card_budgets" do
    solver.stubs(:generation => [9,10,3,24], :overhead => [21,16,42,1])
    solver.transform
    solver.calculate_card_budgets(4).should eq([27, 58, 72, 129])
  end

  it "sum_smallest_budgets_at_step" do
    solver.stubs(:generation => [9,10,3,24], :overhead => [21,16,42,1])
    solver.transform
    solver.sum_smallest_budgets_at_step([25, 26, 30, 45], 2).should eq(51)
  end

  it "find_solutions" do
    solver.stubs(:generation => [9,10,3,24], :overhead => [21,16,42,1])
    solver.transform
    solver.find_solutions.should eq({1=>3, 2=>51, 3=>119, 4=>286})
  end

end