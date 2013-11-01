class Solver

  attr_reader :generation, :overhead, :budget, :cards

  def initialize(generation = [], overhead = [], budget = 0, cards)
    @budget = budget
    @cards = transform
  end

  def solve
    solutions = find_solutions
    puts solutions
    get_answer(solutions)
  end

  def find_solutions
    solutions = {}
    generation.size.times do |i|
      num_cards = i + 1
      # calculate the budgets for each card
      card_budgets = calcuate_card_budgets(num_cards)
      solutions[num_cards] = sum_smallest_budgets_at_step(num_cards)
      # sum = sum_generations(i)
      # break if sum > budget
      # solutions[i+1] = sum
    end
    return solutions
  end

  def sum_smallest_budgets_at_step(budgets, num_cards)
    budgets.slice(0,num_cards).inject(:+)
  end

  def calculate_card_budgets(num_cards)
    cards.collect {|card| card.contribution_to_budget(num_cards)}.sort
  end

  def get_answer(solutions)
    number_of_generations = solutions.keys.sort.last
    {number_of_generations => solutions[number_of_generations]}
  end

  def sum_generations(i)
    sum = 0
    generation.slice(0,i + 1).each_with_index do |element_g, index|
      sum += calculate_time(i, element_g, overhead[index])
    end
    return sum
  end

  def transform
    generation.zip(overhead).collect do |card|
      Card.new(card.first, card[1])
    end
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