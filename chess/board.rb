require_relative 'piece.rb'

class SamePositionError < StandardError; end
class StartPositionNull < StandardError; end
class PositionNil < StandardError; end

class Board

  def initialize
    @grid = Array.new(8){Array.new(8)}
    populate
    # @grid = Board.populate => Alternative population style. Used in junction with Board.populate
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, target)
    row, col = pos
    grid[row][col] = target
  end

  # Alternative population method
  # def self.populate
  #   local_board = Array.new(8) {Array.new(8)}
  #   local_board.each_with_index do |row, row_idx|
  #     row.each_with_index do |col, col_idx|
  #       if row_idx < 2 || row_idx > 5
  #         local_board[row_idx][col_idx] = Piece.new
  #       else0
  #         local_board[row_idx][col_idx] = NullPiece.new
  #       end
  #     end
  #   end
  #
  #   local_board
  # end

  def populate
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        pos = [row_idx, col_idx]
        if row_idx < 2 || row_idx > 5
          self[pos]= Piece.new
        else
          self[pos]= NullPiece.instance
        end
      end
    end
  end

  def display
    grid.each do |row|
      p row
    end
  end

  def move_piece(start_pos, end_pos)
    begin
      
    
      if start_pos == end_pos
        raise SamePositionError
      elsif self[start_pos].is_a? NullPiece
        raise StartPositionNull
      elsif (start_pos + end_pos).any?{|v| v > 7 || v < 0}
        raise PositionNil
      else 
        self[start_pos], self[end_pos] = NullPiece.instance, self[start_pos]
      end
      
    rescue SamePositionError => error
      puts "Start pos cannot be the same as end pos"
    rescue StartPositionNull => error
      puts "There's no piece at the start position"
    rescue PositionNil => error
      puts "Your position(s) is out of bounds"
    end
  end


  attr_reader :grid
end

grid = Board.new
grid.display
