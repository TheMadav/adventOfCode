require 'pp'
require 'CSV'

input = CSV.read("input.txt")
maxX = 0
maxY = 0

puts "=================== STARTING ========================"
coordinates = Hash.new
i = 0
input.each { |e|
  coordinates["L#{i}"] = {'x'=>e[0].to_i, 'y' => e[1].to_i, 'counter' => 0 }
  maxX = e[0].to_i unless maxX > e[0].to_i
  maxY = e[1].to_i unless maxX > e[1].to_i
  i +=1
}

pp coordinates

puts "Grid size #{maxX} to #{maxY}"

puts "=================== Calculate Distance ========================"


def calculateManDistance location, target
#  pp location
#  pp target
  manDistance = (location['x'] - target ['x']).abs + (location['y'] - target['y']).abs
  return manDistance
end


gridpoint = Hash.new
y = 0

while y <= maxY
  x = 0
  while x <= maxX
    i = 0
    #puts "Calculate for #{x}x#{y}"
    coordinates.each { |key, location|
      target= {'x' => x, 'y' => y}

      manDistance = calculateManDistance(location, target)

      if gridpoint.has_key?("#{x}x#{y}")
          gridpoint["#{x}x#{y}"]['sumDistances'] += manDistance

        if gridpoint["#{x}x#{y}"]['distance'] > manDistance
          gridpoint["#{x}x#{y}"]['nextLocation'] = "#{key}"
          gridpoint["#{x}x#{y}"]['distance'] = manDistance

        elsif (gridpoint["#{x}x#{y}"]['distance'] == manDistance && gridpoint["#{x}x#{y}"]['nextLocation'] != "#{key}")
          #puts "!!! #{"#{x}x#{y}"}:  Location #{key} (#{gridpoint["#{x}x#{y}"]['distance']}) and Location #{gridpoint["#{x}x#{y}"]['nextLocation']} (#{manDistance}) => MULT "
          gridpoint["#{x}x#{y}"]['nextLocation'] = "MULT"
        end

      else
        gridpoint["#{x}x#{y}"] = {"nextLocation" => "#{key}", "distance" => manDistance}
        gridpoint["#{x}x#{y}"]['sumDistances'] = manDistance

        if (x == 0 || x == maxX || y == 0 || y == maxY)
          # puts "#{x}x#{y} is on edge "
          gridpoint["#{x}x#{y}"]['onEdge'] = true
        else
          gridpoint["#{x}x#{y}"]['onEdge'] = false
        end

      end
    }

    x+= 1
  end

  y += 1
end
#pp gridpoint

puts "=================== Find location ========================"



# fine for being on the edge

fine = -1*(maxX*maxY)
size = 0
gridpoint.each { |key, value|
  size += 1 unless value['sumDistances'] >= 10000
}
puts size
