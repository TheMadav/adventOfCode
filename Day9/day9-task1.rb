require 'pp'
listOfMarbles = Array.new
listOfMarbles << 0

lastMarble = 70901
numberOfPlayers = 429
marbleValue = 1
score = Array.new(numberOfPlayers).map { |e| e=0  }

pp score

marblePosition = 0
player = 0

while marbleValue < lastMarble
  if marbleValue % 23 == 0

    marblePosition -= 7

    if marblePosition <  0
      puts "Original marblePosition #{marblePosition}"
      marblePosition = listOfMarbles.size + marblePosition
      puts "Changed to #{marblePosition} Circle size #{listOfMarbles.size}"
    end

    puts "Delete Marble number #{listOfMarbles[marblePosition]}"
    removedMarble = listOfMarbles.delete_at(marblePosition)
    score[player-1] += marbleValue + removedMarble
    puts "Round ##{marbleValue}: #{score.join(' | ')}"

  else

    marblePosition = marblePosition + 2

    if marblePosition > listOfMarbles.size
      marblePosition = marblePosition - listOfMarbles.size
    end

    listOfMarbles.insert(marblePosition, marbleValue)

  end

  marbleValue += 1

  #puts "Round #{marbleValue}: player #{player} - #{listOfMarbles}"

  player = (player % (numberOfPlayers)) + 1

end

puts "Result ##{marbleValue}: #{score.join(' | ')}"

puts "High score: #{score.max} for player #{score.index(score.max)+1}"
