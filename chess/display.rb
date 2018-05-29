require_relative 'board.rb'
require_relative 'cursor.rb'
require 'colorize'

class Display
  attr_reader :board, :cursor
  attr_accessor :selected, :selected_pos
  
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
    @selected = false
    @selected_pos = nil
  end
  
  def render
    cur_x, cur_y = cursor.cursor_pos
    sel_x, sel_y = selected_pos
    
    board.grid.length.times do |idx1|
      board.grid.length.times do |idx2|
        if selected && sel_x == idx1 && sel_y == idx2
          print "   ".colorize(:background => :blue)
        elsif idx1 == cur_x && idx2 == cur_y 
          print "   ".colorize(:background => :red)
        elsif (idx1 + idx2).odd?
          print "   ".colorize(:background => :black)
        else
          print "   ".colorize(:background => :white)
        end
      end
      puts
    end
  end
  
  def render_loop
    while true
      system("clear")
      render
      if cursor.get_input
        self.selected = true
        self.selected_pos = cursor.cursor_pos
      end
    end
  end
end