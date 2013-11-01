require_relative 'runner.rb'
require_relative "solver.rb"
map = Map.new
map.import('input.txt')
map.normalize
solver = Solver.new(map)
puts sum = solver.solve
