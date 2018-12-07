require 'pp'

input = File.readlines("input.txt")
blockedSteps = Hash.new
possibleNextSteps = Array.new
inProcessorCompleted = Array.new
solution = String.new

def existFreeWorkers? workers, clock
  workers.each{|worker|
    next unless worker['workingTil'] <= clock
    return true
  }
  return false
end

def calculateWorkTime nextStep, clock
  puts "#{nextStep}: #{(nextStep.ord - 64)}"
  return (clock + nextStep.ord - 4)
end

# Step 1 - Build dependecy Hash

input.map { |e|
    s = e.scan(/Step (\w)/i)
    blockedSteps[s[0][0]] = Array.new unless blockedSteps.has_key?(s[0][0])
    blockedSteps[s[1][0]] = Array.new unless blockedSteps.has_key?(s[1][0])
    blockedSteps[s[1][0]] << s[0][0]
  #  puts "#{e} => #{blockedSteps}"
  }

clock = -1
workers = Array.new(5).map{|e| e = {'workingOn' => nil, 'workingTil' => -1} }

puts "================== START WORKING ================== "

while ! blockedSteps.empty?


  if existFreeWorkers?(workers, clock)
    workers.each{|worker|
      next unless worker['workingTil'] <= clock
      blockedSteps.reject!{|k,v| k == worker['workingOn']}
      blockedSteps.map{ |step, blockedby|
        blockedby.delete( worker['workingOn'] )
      }

      blockedSteps.each{|step,blockedby|
        if ! inProcessorCompleted.include?(step) && ! possibleNextSteps.include?(step) && blockedby.empty?
          possibleNextSteps << step
        end
      }
      possibleNextSteps.sort! { |x,y| y <=> x }
     unless possibleNextSteps.empty?
        nextStep = possibleNextSteps.pop
        inProcessorCompleted << nextStep
        worker['workingTil'] = calculateWorkTime(nextStep, clock)
        worker['workingOn'] = nextStep
      else
          worker['workingOn'] = nil
      end

    }
    pp workers
  end


  puts "----------------"
  clock += 1 unless ! possibleNextSteps.empty? && existFreeWorkers?(workers, clock)
  puts "#{clock}: Workers exist #{existFreeWorkers?(workers, clock) } Work exists #{possibleNextSteps}"

end
#lower bound 220
#upper bound 1238
puts "===================="
# Step 4 print solution
puts "RESULT: #{clock}"
