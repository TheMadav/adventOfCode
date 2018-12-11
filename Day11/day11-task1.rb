require 'pp'
$serialNumber = 5791

maxX = maxY = 300
#maxY = 10
#Fuel cell at  122,79, grid serial number 57: power level -5.
#Fuel cell at 217,196, grid serial number 39: power level  0.

#serialNumber = 42
#x = 122
#y = 79
#fuelCell = Array.new() << [1..300]
#puts fuelCell

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

def calculateSumOfPower fuelCells, x, y
  #puts "#{x}/#{y}"
  includedPWL = Array.new()
  i = y + 2
  j = x + 2
  while y <= i
    while x <= j
      includedPWL << fuelCells[y][x]
      x += 1
    end
    x -= 3
    y += 1
  end
  #pp includedPWL
  return includedPWL.sum
end
fuelCells = Array.new(maxY)


fuelCells.each_index{|y|
  fuelCells[y] =  Array.new(maxX,0)
  fuelCells[y].each_index{ |x|
    fuelCells[y][x] = calculatePower(x+1,y+1)
  }
}

#pp fuelCells

puts "------------ Find Power Level 3x3 Grid -----------------"

y = 0
maxSum = 0
while y < maxY-3
  x = 0
  while x < maxX-3
    sum = calculateSumOfPower(fuelCells, x,y)
    maxSum = [maxSum, sum].max
    if maxSum == sum
      bestCoordinates = [x+1,y+1]
    end
    x += 1
  end
  y += 1
  #puts "Calculated line #{y}"
end
puts "Sum: #{maxSum} | Coordinates #{bestCoordinates}"
