require 'pp'

input = File.readlines("input.txt")
input.sort!
logs = Hash.new
guardLogs = Hash.new

input.each { |line|
  timestamp = line[1...17]
  logs[timestamp]=line[19...-1]
}

def parseLogEntry timestamp
  minute = timestamp[/00:(\d+)/,1]
  minute = 0 if minute.nil?
  return minute.to_i
end

def sumItUp guardlog
    sum = 0
    #puts guardlog
    guardlog.each{|k,v|
      #puts "value #{v}"
      sum += v unless v.nil?
    }
    return sum
end

guardID = nil
$i = 0
$awake = true

logs.each { |timestamp, logentry|

  #puts "#{timestamp}: #{logentry}"
  if logentry .include? "Guard"
    if $awake == false
    #  puts "Guard #{guardID} sleeps until end of shift"
      while i < 60
        guardLogs[guardID][i] += 1
        i += 1
      end
    end

    #puts "-----------------------------------------"
    guardID = logentry[/#+(\d*)/, 1]
    #puts "#{timestamp} #{logentry} || New Day for #{guardID}"
    if guardLogs[guardID].nil?
        # puts "#{timestamp} New Guard #{guardID} - Initializing"
      guardLogs[guardID] = Array.new(59){|i| 0}
      $awake = true
    end
    next

  elsif logentry.include? "falls asleep"
    $sleepsAt = parseLogEntry(timestamp).to_i
    #puts "#{timestamp} #{logentry} || Guard #{guardID} - is asleep at #{$sleepsAt}"
    $awake = false
    next
  elsif logentry.include? "wakes up"
    $awakeAt = parseLogEntry(timestamp).to_i
    $awake = true
    #puts "#{timestamp} #{logentry} || Guard #{guardID} - is awake at #{$awakeAt} was asleep at #{$sleepsAt}"
    i = $sleepsAt

    while i < $awakeAt
      guardLogs[guardID][i] += 1
      i += 1
    end

    next
  end

}
puts "==========================================="

guardAsleep = Hash.new
guardLogs.map{  | guardlog| guardAsleep[guardlog[0]] = guardlog[1].sum }
sorted = guardAsleep.sort_by {|k, v| v}
puts "Most asleep Guard # #{sorted[-1][0]} for #{sorted[-1][1]} minutes"
mostTimesAsleep = guardLogs[sorted[-1][0]].each_with_index.max[1]
puts "Guard # #{sorted[-1][0]} most as sleep in Minute #{mostTimesAsleep}"
puts "ID = #{sorted[-1][0].to_i * mostTimesAsleep}"
