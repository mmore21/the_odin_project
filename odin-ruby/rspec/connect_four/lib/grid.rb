class Grid

  attr_accessor :grid_array
  attr_reader :horizontal

  class Cell

    attr_accessor :used
    attr_reader :point, :row, :column

    def initialize(point)
      @used = nil
      @point = point
      @row = point[0]
      @column = point[1]
    end
  end

  def initialize
    @grid_array = []
    @horizontal = (1..7).to_a
    @vertical = (1..6).to_a
    create
  end

  def create
    @horizontal.each do |i|
      @vertical.each do |j|
        @grid_array << Cell.new([i,j])
      end
    end
  end

  def show
    c = @grid_array.map { |cell| cell.used }
    c.map! { |x| x == nil ? "_" : x }

    puts "_______________"
    puts "|#{c[5]}|#{c[11]}|#{c[17]}|#{c[23]}|#{c[29]}|#{c[35]}|#{c[41]}|"
    puts "|#{c[4]}|#{c[10]}|#{c[16]}|#{c[22]}|#{c[28]}|#{c[34]}|#{c[40]}|"
    puts "|#{c[3]}|#{c[9]}|#{c[15]}|#{c[21]}|#{c[27]}|#{c[33]}|#{c[39]}|"
    puts "|#{c[2]}|#{c[8]}|#{c[14]}|#{c[20]}|#{c[26]}|#{c[32]}|#{c[38]}|"
    puts "|#{c[1]}|#{c[7]}|#{c[13]}|#{c[19]}|#{c[25]}|#{c[31]}|#{c[37]}|"
    puts "|#{c[0]}|#{c[6]}|#{c[12]}|#{c[18]}|#{c[24]}|#{c[30]}|#{c[36]}|"
    puts "|1|2|3|4|5|6|7|"
    puts
  end

  def check_if_won(player)
    @player = player
    return true if check_horizontal || check_vertical || check_diagonal(1) || check_diagonal(1)
  end

  def check_horizontal
    @vertical.length.times do |v|
      current_row = @grid_array.select { |cell| cell.column == v }
      current_row.map! { |cell| cell.used }
      possible = current_row.each_cons(4).to_a
      if possible.any? { |a| a.uniq.length == 1 && a[0] == @player.current_symbol }
        puts "#{@player.current_player} wins!"
        return true
      end
    end
    false
  end

  def check_vertical
    @horizontal.length.times do |h|
      current_column = @grid_array.select { |cell| cell.row == h }
      current_column.map! { |cell| cell.used }
      possible = current_column.each_cons(4).to_a
      if possible.any? { |a| a.uniq.length == 1 && a[0] == @player.current_symbol }
        puts "#{@player.current_player} wins!"
        return true
      end
    end
    false
  end

  def check_diagonal(direction)
    # KEY: DIRECTION (AREA OF GRID IT COVERS)

    # horizontal northeast (lower right)
    1.upto(7) do |n|
      point = [n,1]
      points = find_points(point, 1)
      possible = points.flatten.each_cons(4).to_a
      if possible.any? { |a| a.uniq.length == 1 && a[0] == @player.current_symbol }
        puts "#{@player.current_player} wins!"
        return true
      end
    end

    # vertical northeast (upper left)
    1.upto(7) do |n|
      point = [1,n]
      points = find_points(point, 1)
      possible = points.flatten.each_cons(4).to_a
      if possible.any? { |a| a.uniq.length == 1 && a[0] == @player.current_symbol }
        puts "#{@player.current_player} wins!"
        return true
      end
    end

    # horizontal northwest (lower left)
    7.downto(1) do |n|
      point = [n,1]
      points = find_points(point, -1)
      possible = points.flatten.each_cons(4).to_a
      if possible.any? { |a| a.uniq.length == 1 && a[0] == @player.current_symbol }
        puts "#{@player.current_player} wins!"
        return true
      end
    end

    # vertical northwest (upper right)
    7.downto(1) do |n|
      point = [1,n]
      points = find_points(point, -1)
      possible = points.flatten.each_cons(4).to_a
      if possible.any? { |a| a.uniq.length == 1 && a[0] == @player.current_symbol }
        puts "#{@player.current_player} wins!"
        return true
      end
    end
    false
  end

  def find_points(point, direction)
    points = []
    grid_points = @grid_array.map { |cell| cell.point }
    while grid_points.include?(point)
      points << find_cell(point)
      point = [(point[0]+direction), (point[1]+1)]
    end
    points.each do |x|
      x.map! { |cell| cell.used }
    end
    return points
  end

  def find_cell(point)
    target = @grid_array.select { |cell| cell.point == point }
    target
  end

end
