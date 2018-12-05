require 'pp'

inputString = File.read("input.txt").strip!
#inputString = "dabAcCaCBAcCcaDA"

puts "Starting - whole string is #{inputString.size}"
def findPattern searchString
  foundPattern = true
  restartAt = 0
  currentSize = searchString.size

  while foundPattern
    if currentSize > searchString.size
      echo "Something weird happened - stopping"
    end

    firstLetter = searchString.index(/(\w)\1+/i, restartAt)

    if firstLetter.nil?
      #foundPattern = false
      return searchString
    end

    pattern = searchString[firstLetter]+searchString[firstLetter+1]

    if searchString[firstLetter] != searchString[firstLetter+1]
      searchString.gsub!(pattern, '')
      restartAt = 0
      currentSize = searchString.size
      #puts "-------Terminate: #{ pattern } retstart at #{restartAt} currentSize #{currentSize}"
    else
      restartAt = firstLetter+1
      #puts "No Termination: #{pattern} retstart at #{restartAt} | currentSize #{currentSize}"
    end

  end
end
output = findPattern inputString

puts "================================="
puts output.size
puts "================================="

inputString = File.read("input.txt").strip!
listOfSizes = Hash.new
('a'..'z').to_a.each{ |letter|
  inputString = File.read("input.txt").strip!
  listOfSizes[letter] = (findPattern inputString.tr("#{letter}#{letter.upcase}", '')).size
  puts "Whole String #{inputString.size} - shorter version #{listOfSizes[letter]}"
}
sorted = listOfSizes.sort_by {|k, v| v}
puts "Minimal size #{sorted[0]}"
