require 'pp'

claims = File.readlines("input.txt")
claimedLocations = Hash.new
claims.each{|claim|

  claimArray = claim.split(" ")
  coordinates = claimArray[2].split(",")
  dimensions = claimArray[3].split("x")
  xCoordinate = coordinates[0].to_i
  yCoordinate = coordinates[1][0..-2].to_i
  length = xCoordinate + dimensions[0].to_i
  height = yCoordinate + dimensions[1].to_i

  original = yCoordinate
  while xCoordinate < length
    yCoordinate = original
    while yCoordinate < height
      if claimedLocations["#{xCoordinate}X#{yCoordinate}"].nil?
        claimedLocations["#{xCoordinate}X#{yCoordinate}"] = 1
      else
        claimedLocations["#{xCoordinate}X#{yCoordinate}"] = claimedLocations["#{xCoordinate}X#{yCoordinate}"] + 1
      end
      yCoordinate = yCoordinate +1
    end
    xCoordinate = xCoordinate+1

  end
}
duplicated = claimedLocations.reject{|k,v| v == 1}
#pp duplicated
puts duplicated.count
