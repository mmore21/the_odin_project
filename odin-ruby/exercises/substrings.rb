def substrings(str, dict)
  occurences = Hash.new(0)
  str.downcase!
  dict.each do |word|
    num_occurences = str.scan(word)
    # only returns the words that appear at least once
    occurences[word] = num_occurences.length unless num_occurences.length < 1
  end
  return occurences
end

# this is a test case, change to see different results
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit", "below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

# this is another variable, change the input entered to see different results
puts "Enter a phrase to see how much the words in the dictionary occur!'"
input = gets.chomp.to_s
substrings(input, dictionary)