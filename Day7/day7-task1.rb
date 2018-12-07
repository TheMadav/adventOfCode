require 'pp'

input = File.readlines("input.txt")
blockedSteps = Hash.new
possibleNextSteps = Array.new
solution = String.new

# Step 1 - Build dependecy Hash

input.map { |e|
    s = e.scan(/Step (\w)/i)
    blockedSteps[s[0][0]] = Array.new unless blockedSteps.has_key?(s[0][0])
    blockedSteps[s[1][0]] = Array.new unless blockedSteps.has_key?(s[1][0])
    blockedSteps[s[1][0]] << s[0][0]
  #  puts "#{e} => #{blockedSteps}"
  }
# Step 2 find unblocked blockedSteps
puts "--------- Start finding unblocked steps -------------"
while ! blockedSteps.empty?

  blockedSteps.each{|step,blockedby|
    if blockedby.empty?
      possibleNextSteps << step
      blockedSteps.reject!{|k,v| k == step}
    end
  }
  puts "Possible next Steps: #{possibleNextSteps}"

  # Step 3 select next step and remove from dependency Hash
  possibleNextSteps.sort! { |x,y| y <=> x }
  nextStep = possibleNextSteps.pop

  solution << nextStep
  puts "Current solution: #{solution}"
  blockedSteps.map{ |step, blockedby|
    blockedby.delete(nextStep)
  }


end
puts "===================="
# Step 4 print solution
puts "RESULT: #{solution}"
