require "pp"

frequencies = Array.new
frequencies << 0

runs = 1

def findDuplicate frequencies

    frequency = frequencies.last

    #sleep(1)

    File.foreach("input.txt") { |x|
    if x[0]=="+"
      change = x[1..-1]
    else
      change = x
    end

    frequency = frequency + change.to_i
    # puts "#{value} Number of values #{values.size}"

    if frequencies.include?(frequency)
      print "First duplicate: #{frequency}\n"
      #print "All values: #{values}\n"
      exit
    end
    frequencies << frequency
  }
  return frequencies
end

while true

  puts "--- Run #{runs} - last value is #{frequencies.last} | Number of frequencies #{frequencies.count}"
  frequencies = findDuplicate frequencies
  runs = runs +1
end
