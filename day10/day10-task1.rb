require 'pp'

$minSize = Array.new
$startCoordinates = Array.new

input = File.readlines("input.txt")

input.each { |e|
  e.strip!
  $startCoordinates << {
      :x => e[/position=<(.?\d*)/, 1].to_i,
      :y => e[/position=<.?\d*, (.?\d*)>/,1].to_i,
      :xv=> e[/velocity=<(.?\d*)/, 1].to_i,
      :yv=> e[/velocity=<.?\d*, (.?\d*)/,1].to_i
    }
}

def calculateCoordinates seconds

  coordinates = Array.new
  $startCoordinates.each{|c|
    coordinates << {:x=> c[:x]+c[:xv]*seconds, :y=>c[:y]+c[:yv]*seconds}
  }
  minY, maxY  = coordinates.minmax_by{ |e| e[:y]}
  minX, maxX  = coordinates.minmax_by{ |e| e[:x]}
  $minY       = minY[:y]
  $maxY       = maxY[:y]
  $minX       = minX[:x]
  $maxX       = maxX[:x]
  return coordinates
end

def drawDiagram coordinates, iteration
  puts "Creating diagram for step #{iteration}"
  File.write("./output/result-iteration#{iteration}.txt", "Step #{iteration} - X: #{$minX} - #{$maxX} / Y: #{$minY} - #{$maxY}\n")

  y = [$minY,-100].max

  while y <= [$maxY, 300].min

    x = $minX
    output = "#{y} \t"

    while x<= [$maxX,500].min
      foundOne = false
      coordinates.each{ |c|
        if c[:x] == x && c[:y] == y && foundOne == false
          output << "#"
          foundOne = true
        end
      }

      output << "." unless foundOne == true
      x +=1
    end

    File.write("./output/result-iteration#{iteration}.txt", "#{output} || #{output.size}\n", mode: 'a')
    y +=1
  end
end


i = 0

while i < 100000
  coordinates = calculateCoordinates i
  $sizeX      = $maxX - $minX
  $minSize    << $sizeX

  puts "Step #{i} #{$minY}/#{$maxY} : (#{$sizeY}/#{$minSize.last})"

  if ! $minSize[-2].nil? && $minSize[-1] > $minSize[-2]
    puts "-----------"
    coordinates = calculateCoordinates i-1
    puts  "Step #{i-1} - X: #{$minX} - #{$maxX} / Y: #{$minY} - #{$maxY}\n"
    drawDiagram coordinates, i-1
    exit
  end
    i += 1
end
