class Solver

  attr_reader :generation, :overhead, :budget, :cards

  def initialize(generation = [], overhead = [], budget = 0)
    @budget = budget
    @generation = generation
    @overhead = overhead
  end

  def solve
    highest_number_of_cards_in_solutions(find_solutions)
  end

  def find_solutions
    solutions = {}
    generation.size.times do |i|
      num_cards = i + 1
      card_budgets = calculate_card_budgets(num_cards)
      sum = sum_smallest_budgets_at_step(card_budgets, num_cards)
      break if sum > 2912
      solutions[num_cards] = sum
    end
    return solutions
  end

  def sum_smallest_budgets_at_step(budgets, num_cards)
    budgets.slice(0,num_cards).inject(:+)
  end

  def calculate_card_budgets(num_cards)
    cards.collect {|card| card.contribution_to_budget(num_cards)}.sort
  end

  def highest_number_of_cards_in_solutions(solutions)
    solutions.keys.sort.last
  end

  def transform
    @cards = generation.zip(overhead).collect do |card|
      create_card(card)
    end
  end

  def create_card(card)
    Card.new(card.first, card[1])
  end

end

class Card

  attr_reader :g, :o

  def initialize(g,o)
    @g = g
    @o = o
  end

  def contribution_to_budget(num_cards)
    ((num_cards - 1) * o) + g
  end

end