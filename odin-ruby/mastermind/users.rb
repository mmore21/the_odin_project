class Human
  include GameFlow
  def guess
    return get_input
  end
end

class AI
  include GameFlow
  def initialize(difficulty)
    @difficulty = difficulty
    @hint_hash = Hash.new(0)
    @@count = 0
    @guesses = []
  end
  
  def guess
    if @difficulty == "Stupid"
      guess_stupid
    elsif @difficulty == "Smart"
      @hints = guess_smart
    elsif @difficulty == "Perfect"
      guess_perfect
    end
  end
  
  def guess_stupid
    random = random_number
    puts random
    return random
  end
  
  def guess_smart
    @@count += 1
    if @@count <= 6
      number = "11" + (@@count.to_s * 2)
      puts "Bot guesses #{number}."
      return number
    else
      number_array = []
      @hint_hash.each do |k,v|
        v.to_i.times do |x|
          number_array.push(k)
        end
      end
      number = number_array.shuffle.join
      while @guesses.include?(number)
        number = number_array.shuffle.join
      end
      @guesses.push(number)
      puts "Bot guesses #{number}."
      return number
    end
  end
  
  def guess_perfect
    puts "Bot guesses #{@solution}."
    return @solution
  end
  
  def give_hints(info)
    occurences = info
    if @@count == 1
      @one_occurences = occurences
      @hint_hash["#{@@count}"] = @one_occurences
      @one_occurences -= 1 if @one_occurences == 3
    elsif @@count <= 6
      @hint_hash["#{@@count}"] = (occurences.to_i - @one_occurences.to_i)
    end
    if @@count >= 6
      @hint_hash.delete_if { |key, value| value == 0 }
      if @hint_hash.length == 2
        num = @hint_hash[@hint_hash.key(2)] + 1
        @hint_hash[@hint_hash.key(2)] = num
      elsif @hint_hash.length == 1
        num = @hint_hash[@hint_hash.key(2)] + 2
        @hint_hash[@hint_hash.key(2)] = num
      end
    end
  end
  
  def get_solution(solution)
    @solution = solution
  end
end