require "pp"


twoOccurence = 0
threeOccurence = 0

File.foreach("input.txt") { |code|
  #puts code
  counts = code.downcase.gsub(/[^a-z]/,'').
             each_char.
             with_object(Hash.new(0)) { |c,h| h[c] += 1 }

  twoOccurence = twoOccurence + 1 if counts.has_value?(2)
  threeOccurence = threeOccurence +1 if counts.has_value?(3)

  #puts "Current code = #{code} - Doubles #{twoOccurence} Tripples #{threeOccurence}"
}

checksum = twoOccurence*threeOccurence
puts "Checksum #{checksum}"
