require 'pp'
$serialNumber = 5791

maxX = maxY = 300

def calculatePower x,y

  # For example, to find the power level of the fuel cell at 3,5 in a grid with serial number 8
  # Find the fuel cell's rack ID, which is its X coordinate plus 10.
  # == The rack ID is 3 + 10 = 13.
  rackID = x + 10

  # Begin with a power level of the rack ID times the Y coordinate.
  # Increase the power level by the value of the grid serial number (your puzzle input).
  # Set the power level to itself multiplied by the rack ID.
  # == The power level starts at 13 * 5 = 65.
  # == Adding the serial number produces 65 + 8 = 73.
  # == Multiplying by the rack ID produces 73 * 13 = 949.
  powerLevel = (rackID * y + $serialNumber) * rackID

  # Keep only the hundreds digit of the power level (so 12345 becomes 3; numbers with no hundreds digit become 0).
  # The hundreds digit of 949 is 9.
  # Subtract 5 from the power level.
  # Subtracting 5 produces 9 - 5 = 4.
  powerLevel = powerLevel.to_s[-3].to_i-5

end

def calculateSumOfPower fuelCells, x, y, size

  includedPWL = Array.new()
  i = y + size-1
  j = x + size-1

  lines = fuelCells[y..i]
  lines.each{|line|
    includedPWL << line[x..j]
  }
  return includedPWL.flatten.sum

end

puts "Starting, calculate Power Cells "
fuelCells = Array.new(maxY)

fuelCells.each_index{|y|
  fuelCells[y] =  Array.new(maxX,0)
  fuelCells[y].each_index{ |x|
    fuelCells[y][x] = calculatePower(x+1,y+1)
  }
}

puts "Serial number: #{$serialNumber} \t Grid size: #{maxX} "
puts "------------ Find Power Level Grid -----------------"

maxSum = 0
size = 1

while size <= maxX
  y = 0
  while y <= maxY-size
    x = 0
    while x <= maxX-size
      sum = calculateSumOfPower(fuelCells, x,y, size)
      maxSum = [maxSum, sum].max
      if maxSum == sum
        bestCoordinates = [x+1,y+1, size]
      end
      x += 1
    end
    y += 1
  end

  puts "Current Size: #{size} \t| Sum: #{maxSum} \t| Coordinates #{bestCoordinates}"
  size += 1
end
puts "==============================================="
puts "Sum: #{maxSum} | Coordinates #{bestCoordinates}"
