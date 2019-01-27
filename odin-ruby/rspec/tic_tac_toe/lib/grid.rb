class Grid
  attr_accessor :grid_array, :boxes_left
  def initialize(player)
    @grid_array = (1..9).map { |n| n.to_s }
    @boxes_left = @grid_array.length
    @player = player
  end

  def show
    puts " #{@grid_array[0]} | #{@grid_array[1]} | #{@grid_array[2]} "
    puts "-----------"
    puts " #{@grid_array[3]} | #{@grid_array[4]} | #{@grid_array[5]} "
    puts "-----------"
    puts " #{@grid_array[6]} | #{@grid_array[7]} | #{@grid_array[8]} "
  end

  def move(input)
    @grid_array[input.to_i - 1] = @player.current_symbol
    @boxes_left -= 1
  end

  def check_if_won
    a = @grid_array
    solutions = [
                    [a[0], a[1], a[2]],
                    [a[3], a[4], a[5]],
                    [a[6], a[7], a[8]],
                    [a[0], a[3], a[6]],
                    [a[1], a[4], a[7]],
                    [a[2], a[5], a[8]],
                    [a[0], a[4], a[8]],
                    [a[2], a[4], a[6]]
                   ]
    if solutions.any? { |array| array.uniq.count == 1 }
      puts "#{@player.current_player} wins."
      return false
    elsif @boxes_left == 0
      puts "It's a scratch!"
      return false
    end
    return true
  end
end
