require 'pp'

$input = File.read("input.txt").strip!.split(" ")


$value = 0
puts "Input: #{$input}"

puts "================== START WORKING ================== "



def licenseParser
  hasChilds = false
  numberOfNodes = $input.shift.to_i
  numberOfIndizes = $input.shift.to_i
  tree = Array.new(numberOfNodes+numberOfIndizes)
  puts "First tree #{tree} based on Nodes #{numberOfNodes} and Indizes #{numberOfIndizes}"
  i = 0
  while i < numberOfNodes
    tree[i] = licenseParser
    i += 1
    puts "Tree structure: #{tree} and i = #{i}"
    hasChilds = true
  end

  while i < (numberOfIndizes+numberOfNodes)
    tree[i] = $input.shift.to_i
    i += 1
    puts "Tree with Indizes #{tree} and i = #{i}"
  end
  return tree
end

def calculateNodeValue tree, level

  value = 0
  hasChilds = false
  puts "------------------------"
  puts "Checking tree on level #{level} - size is #{tree.size}"
  tree.each{|leaf|
    if leaf.kind_of?(Array)
      hasChilds = true
      next
    end
  }
  if hasChilds == false
    puts "No children, value of indizes: #{tree.sum}"
    return tree.sum
  else
    puts "Children exists, checking indizes"
    i = -1
    tree.each{|leaf|
      i += 1

      if leaf.kind_of?(Array)
        puts "Index #{i} is an Array"
        next
      else
        puts "Index #{i} has value #{leaf}"
        if tree[leaf-1].nil? || ! tree[leaf-1].kind_of?(Array)
          puts "Index #{leaf} did not exist, value is 0"
        else
          puts "Index #{leaf} exist, calculate value"
          value += calculateNodeValue(tree[leaf-1], level+1)
          puts "------------------------"
          puts "Back on level #{level } -  value is #{value}"
        end
      end

    }
      return value
  end
end

completeTree = licenseParser
puts "================== Calculate Node Value ================== "
sum = calculateNodeValue(completeTree,1)

puts "================== RESULT ================== "w
puts sum
