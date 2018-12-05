require "pp"
require 'levenshtein'

codes = File.readlines("input.txt")

while codes.length > 0
  initialCode = codes.pop.strip!

  codes.map { |secondaryCode|

    distance = Levenshtein.distance initialCode, secondaryCode

    next unless distance == 1

    puts "Found it:\n (1) #{initialCode} \n (2) #{secondaryCode}"

    i = 0

    while i < (initialCode.size)

      i +=1

      next unless initialCode[i] != secondaryCode[i]

      initialCode.slice!(i)
      puts "----------------\nRESULT:"
      puts initialCode
      exit
    end

    puts "mbruvapghxlzycbhmfqjonsie"


  }
end
