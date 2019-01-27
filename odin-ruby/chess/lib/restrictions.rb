module Restrictions

  def moves_inside_board(possible)
    possible.select{ |a| (a[0] >= 1 && a[0] <= 8) && ( a[1] >= 1 && a[1] <= 8 ) }
  end

  def validate_diagonal_slide(origin, target, cells)
    if origin.occupant.class == Bishop || origin.occupant.class == Queen
      path = [origin.coordinate[0]-target.coordinate[0], origin.coordinate[1] - target.coordinate[1]]
      directions = [[1,1], [1,-1], [-1,1], [-1,-1]]
      current_coord = target.coordinate
      if path[0] > 0 && path[1] > 0
        direction = [1,1]
      elsif path[0] > 0 && path[1] < 0
        direction = [1,-1]
      elsif path[0] < 0 && path[1] > 0
        direction = [-1,1]
      elsif path[0] < 0 && path[1] < 0
        direction = [-1,-1]
      else
        return true
      end

      until current_coord == [origin.coordinate[0] - direction[0], origin.coordinate[1] - direction[1]]
        current_coord = [current_coord[0] + direction[0], current_coord[1] + direction[1]]
        current_cell = (cells.select { |c| c.coordinate == current_coord }).first
        return false if current_cell.occupant != nil
      end
    end
    true
  end

  def validate_straight_slide(origin, target, cells)
    if origin.occupant.class == Rook || origin.occupant.class == Queen
      path = [origin.coordinate[0]-target.coordinate[0], origin.coordinate[1]-target.coordinate[1]]
      current_coord = target.coordinate
      if path[0] == 0 && path[1] > 0
        direction = [0,1]
      elsif path[0] == 0 && path[1] < 0
        direction = [0,-1]
      elsif path[0] > 0 && path[1] == 0
        direction = [1,0]
      elsif path[0] < 0 && path[1] == 0
        direction = [-1,0]
      else
        return true
      end

      until current_coord == [origin.coordinate[0] - direction[0], origin.coordinate[1] - direction[1]]
        current_coord = [current_coord[0] + direction[0], current_coord[1] + direction[1]]
        current_cell = (cells.select{ |c| c.coordinate == current_coord }).first
        return false if current_cell.occupant != nil
      end
    end
    true
  end

  def special_pawn_move(origin, target, cells)
    if origin.occupant.class == Pawn
      if origin.occupant.player.number == 0
        direction = [2,1]
      elsif origin.occupant.player.number == 1
        direction = [-2,-1]
      end
      if origin.occupant.initial == true
        current_cell = (cells.select{ |c| c.coordinate == [origin.coordinate[0], origin.coordinate[1] + direction[0]] }).first
        return false if target.coordinate == current_cell.coordinate && current_cell.occupant != nil
      end
      current_cell = (cells.select{ |c| c.coordinate == [origin.coordinate[0], origin.coordinate[1] + direction[1]] }).first
      return false if target.coordinate == current_cell.coordinate && current_cell.occupant != nil

      possible_diagonal = []
      possible_coordinates = moves_inside_board([[origin.coordinate[0]-1, origin.coordinate[1]+direction[1]], [origin.coordinate[0]+1, origin.coordinate[1]+direction[1]]])
      possible_coordinates.each do |possible|
        current_cell = (cells.select{ |c| c.coordinate == possible }).first
        if current_cell.occupant != nil
          possible_diagonal << possible if current_cell.occupant.player.number != origin.occupant.player.number
        end
      end
      return possible_diagonal
    else
      return []
    end
  end


end
