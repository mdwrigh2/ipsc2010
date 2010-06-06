#!/usr/bin/env ruby
class Input
  attr_accessor :size, :array

  def initialize(size)
    @size = size
    if size <= 3
      puts "Warning: Set of size 3 or less"
    end
    @array = Array.new
  end

  def is_sorted?
    (0...@array.length-1).each do |i|
      if(@array[i] > @array[i+1])
        return false
      end
    end
    return true
  end

  def is_sorted_descending?
    (0...@array.length-1).each do |i|
      if(@array[i] < @array[i+1])
        return false
      end
    end
    return true
  end
end

def read_input(filename)
  file = File.open(filename, "r")
  test_cases = file.readline.strip.to_i
  input_arrays = Array.new
  (1..test_cases).each do |i|
    file.readline
    input = Input.new(file.readline.strip.to_i)
    line = file.readline
    line.scan(/([-]?[0-9]+)/) do |number|
      input.array << number.first.to_i
    end
    input_arrays << input
  end
  return input_arrays
end

if ARGV.length != 2
  puts ""
  puts "problemA [infile] [outfile]"
  puts "ERROR: Two arguments required"
  puts ""
  exit(1)
end

inputs = read_input(ARGV[0])

file = File.new(ARGV[1], "w")

file.puts(inputs.length)


inputs.each do |input|
  file.puts ""
  file.puts input.size
  if input.is_sorted?
    temp = input.array[-1]
    input.array[-1] = input.array[0]
    input.array[0] = temp
  end
  if input.is_sorted_descending?
    temp = input.array[-1]
    input.array[-1] = input.array[0]
    input.array[0] = temp
  end
  input.array.each do |number|
    file.print(number.to_s+" ")
  end
  file.print("\n")
end

file.close

