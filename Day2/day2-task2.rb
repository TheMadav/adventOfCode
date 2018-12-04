require "pp"
require 'levenshtein'

codes = File.readlines("input.txt")

while codes.length > 0
  initialCode = codes.pop

  codes.each{|secondaryCode|
    distance = Levenshtein.distance initialCode, secondaryCode
    if distance == 1
      puts "Found it:"
      puts initialCode
      puts secondaryCode
      puts "----------------"
      # Find wrong letter manually
      exit
    end
  }

end

exit
