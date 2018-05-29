require 'singleton'

class Piece
end

class NullPiece < Piece
  include Singleton
end

class King < Piece
end

class Queen < Piece
end

class Bishop < Piece
end

class Knight < Piece
end

class Rook < Piece
end

class Pawn < Piece
end
