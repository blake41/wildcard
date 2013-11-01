class Solver

  def initialize(map)
    @map = map
    @solutions = []
  end

  def solve
    check_rows
    check_columns
    permute_solutions
  end

  def solutions
    @solutions
  end

  def permute_solutions
    sum = solutions.inject(0) do |acc, element|
      acc + n_choose_k(element, 5)
    end
    return sum
  end

  def n_choose_k(n,k)
    factorial(n) / factorial(n-k)
  end

  def factorial(n)
    return 1 if n == 0
    n.downto(1).inject(:*)
  end

  def map
    @map
  end

  def check_rows
    map.matrix.each_with_index do |row, index|
      empties = map.number_of_empty_spots_in_a_row(row)
      if empties > 4
        @solutions << empties
      end
    end
  end

  def check_columns
    map.matrix.size.times do |i|
      spots_in_column = 0
      map.matrix.each do |row|
        spots_in_column +=1 if row[i] == 0
      end
      if spots_in_column > 4
        @solutions << spots_in_column
      end
    end
  end

end

class Map

  attr_reader :matrix

  def initialize
    @matrix = []
  end

  def import(file)
    File.open(file) do |file|
      file.each_line do |line|
        @matrix << line.chomp.split(//)
      end
    end
  end

  def normalize
    @matrix = @matrix.collect do |row|
      row.collect do |element|
        if element == "X"
          1
        elsif element == "*"
          0
        end
      end
    end
  end

  def number_of_empty_spots_in_a_row(row)
    row.select {|element| element == 0}.count
  end
end