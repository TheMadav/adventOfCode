require 'pp'

claims = File.readlines("input.txt")
claimedLocations = Hash.new
noOverlap = true
listOfClaims = Array.new
overlappedClaims = Array.new
claims.each{|claim|

  claimArray = claim.split(" ")
  coordinates = claimArray[2].split(",")
  dimensions = claimArray[3].split("x")
  xCoordinate = coordinates[0].to_i
  yCoordinate = coordinates[1][0..-2].to_i
  length = xCoordinate + dimensions[0].to_i
  height = yCoordinate + dimensions[1].to_i
  listOfClaims << claimArray[0]
  original = yCoordinate
  noOverlap = true

  while xCoordinate < length
    yCoordinate = original

    while yCoordinate < height
      if claimedLocations["#{xCoordinate}X#{yCoordinate}"].nil?
        claimedLocations["#{xCoordinate}X#{yCoordinate}"] = claimArray[0]
      else
        overlappedClaims << claimArray[0]
        overlappedClaims <<   claimedLocations["#{xCoordinate}X#{yCoordinate}"]
      end
      yCoordinate = yCoordinate +1
    end
    xCoordinate = xCoordinate+1
  end

}
puts overlappedClaims.uniq!.count
puts listOfClaims.count
puts listOfClaims-overlappedClaims
