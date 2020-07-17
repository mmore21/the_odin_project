def palindrome(str)
  return true if str.length == 1 || str.length == 0
  return false if str[0] != str[-1]
  palindrome(str[1..-2])
end

string = gets.chomp
palindrome(string)
