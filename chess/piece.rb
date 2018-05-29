require 'singleton'

class Piece
  attr_reader :board
  
  def initialize#(color, board, position)
    # @color = color
    # @board = board
    # @position = position
  end
  
  def to_s
    #{}"  k  ".colorize(:light_yellow)
  end
  
  def moves
  end
end

class NullPiece < Piece
  include Singleton
end

module SlidingPiece
  def moves(position)
    available_pos = move_dirs
  end
  
  def move_dirs
  # Intentionally left blank
  # hori_vert :Called by the Rook
  # diagonal :Called by the bishop
  # hori_vert + diagonal :Called by Queen
  end
  
  def hori_vert
    curr_x, curr_y = position
    arr = []
    
    4.times do |direction|
      i = (direction+1) % 2 # => 1, 0, 1, 0
      i *= -1 if direction >= 2
      
      j = direction % 2     # => 0, 1, 0, 1
      j *= -1 if direction >= 2
      
      new_pos = [curr_x+i, curr_y+j]
      
      while board[new_pos].is_a? NullPiece || new_pos.any?{|v| v < 0}
        arr << new_pos
        
        unless i == 0
          i = (i > 0 ? i+1 : i-1)
        end
        unless j == 0
          j = (j > 0 ? j+1 : j-1)
        end
        
        new_pos = [curr_x+i, curr_y+j]
        
        if board[new_pos].color != self.color
          arr << [new_pos]
          break
        end
      end
    end
    
    arr
  end
  
  
  def diagonal
    curr_x, curr_y = position 
    arr = []
    i = 1
    new_pos = [curr_x+i, curr_y+i] 
    while board[new_pos].is_a? NullPiece || new_pos.any?{|v| v < 0}
      arr << new_pos
      i += 1
      new_pos = [curr_x+i, curr_y+i]
      if board[new_pos].color != self.color
        arr << new_pos
        break
      end
    end
    
    i = -1
    j = 1
    new_pos = [curr_x+i, curr_y+j] 
    while board[new_pos].is_a? NullPiece || new_pos.any?{|v| v < 0}
      arr << new_pos
      i -= 1
      j += 1
      new_pos = [curr_x+i, curr_y+j]
      if board[new_pos].color != self.color
        arr << new_pos
        break
      end
    end
    
    i = 1
    j = -1
    new_pos = [curr_x+i, curr_y+j] 
    while board[new_pos].is_a? NullPiece || new_pos.any?{|v| v < 0}
      arr << new_pos
      i += 1
      j -= 1
      new_pos = [curr_x+i, curr_y+j]
      if board[new_pos].color != self.color
        arr << new_pos
        break
      end
    end
    
    i = -1
    j = -1
    new_pos = [curr_x+i, curr_y+j] 
    while board[new_pos].is_a? NullPiece || new_pos.any?{|v| v < 0}
      arr << new_pos
      i -= 1
      j -= 1
      new_pos = [curr_x+i, curr_y+j]
      if board[new_pos].color != self.color
        arr << new_pos
        break
      end
    end    
    
    arr 
  end
end

module SteppingPiece
  def king_move
    move_arr = [[1,0], [1,1], [0,1], [-1,1], [-1,0],[-1,-1], [0,-1], [1,-1]]
    curr_x, curr_y = position
    arr = []
    
    move_arr.each do |move|
      x,y = move
      new_pos = [curr_x+x, cur_y+y]
      if board[new_pos].is_a? NullPiece || new_pos.any?{|v| v < 0} || board[new_pos].color != self.color
        arr << new_pos
      end
    end
    
    arr
  end
end

class Pawns
end