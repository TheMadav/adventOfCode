require 'pp'

example = false
if example
  state = "...#..#.#..##......###...###"
  lines = File.read("example.txt").strip!.split("\n")
else
  state = "...#.#####.##.###...#...#.####..#..#.#....##.###.##...#####.#..##.#..##..#..#.#.#.#....#.####....#..#"
  lines = File.read("input.txt").strip!.split("\n")
end



rules = Hash.new
lines.each{ |line| rules[line[0...5]] = line[-1,1] }

maxGeneration = 50000000000
currentPotIndex = 2
generation = 1
output = "0:\t#{state} \n"


while generation <= maxGeneration

  #output << "#{generation} \t"
  currentPotIndex = 0
  nextGeneration = ""

  puts "Current generation: #{generation}" if generation % 1000 == 0

  while currentPotIndex < state.length

    case currentPotIndex
    when 0
      checkString  = "..#{state[currentPotIndex..currentPotIndex+2]}"
    when 1
      checkString  = ".#{state[currentPotIndex-1..currentPotIndex+2]}"
    when state.length-2
      checkString  = "#{state[currentPotIndex-2..currentPotIndex+1]}."
    when state.length-1
      checkString  = "#{state[currentPotIndex-2..currentPotIndex]}.."
    else
      checkString  = state[currentPotIndex-2..currentPotIndex+2]
    end

    if rules.has_key?(checkString)
      nextGeneration << rules[checkString]
      #puts "Key exist #{state[currentPotIndex-2..currentPotIndex+2]}: #{rules[state[currentPotIndex-2..currentPotIndex+2]]}"
    else
      puts "exist"
      nextGeneration << "."
    end

    currentPotIndex += 1

  end
  state = "#{nextGeneration}."
#  output << "#{nextGeneration} \n"
  generation +=1
end
puts output

i = -3
sum = 0
state.split('').each{|c|
  sum = sum+i if c == '#'
  i += 1
}

puts "==============================="
# Lower Bound 3987
puts "Sum #{sum}"
