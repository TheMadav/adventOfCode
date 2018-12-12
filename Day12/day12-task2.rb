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

maxGeneration = 1000
generation = 0
oldsum = 0
while generation <= maxGeneration

  #output << "#{generation} \t"
  currentPotIndex = 0
  nextGeneration = ""

  if generation > 300 # == 0

      i = -3
      sum = 0
      state.split('').each{|c|
        sum = sum+i if c == '#'
        i += 1
      }
      puts "#{generation} \t #{sum} \t #{sum-oldsum}"
      oldsum = sum
  end
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

    nextGeneration << rules[checkString]
    currentPotIndex += 1
  end
  state = "#{nextGeneration}."
  generation +=1
end
puts "==============================="
# Change per genertation is 194
puts (57521 + (50000000000-300)*194)
