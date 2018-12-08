require 'pp'

$input = File.read("input.txt").strip!.split(" ")

puts "Input: #{$input}"

puts "================== START WORKING ================== "



def licenseParser
  numberOfNodes = $input.shift.to_i
  numberOfIndizes = $input.shift.to_i
  tree = Array.new(numberOfNodes+numberOfIndizes)
  puts "First tree #{tree} based on Nodes #{numberOfNodes} and Indizes #{numberOfIndizes}"
  i = 0
  while i < numberOfNodes
    tree[i] = licenseParser
    i += 1
    puts "Tree structure: #{tree} and i = #{i}"
  end

  while i < (numberOfIndizes+numberOfNodes)
    tree[i] = $input.shift.to_i
    i += 1
    puts "Tree with Indizes #{tree} and i = #{i}"
  end
  return tree
end

result = licenseParser
pp result

puts "================== RESULT ================== "
sum = 0
result.flatten.each{|e| sum+= e unless e.nil?}
puts sum
