require_relative 'board.rb'
require_relative 'cursor.rb'
require 'colorize'

class Display
  attr_reader :board
  
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], self.board)
  end
  
  def render
    
  end
end