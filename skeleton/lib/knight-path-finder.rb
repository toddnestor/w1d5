require_relative '00_tree_node'

class KnightPathFinder
  def initialize(pos)
    raise unless on_board?(pos)
    @root = PolyTreeNode.new(pos)
    @visited_positions = [pos]
    build_move_tree
  end

  MOVES = [
    [-2,1],
    [-2,-1],
    [-1,2],
    [-1,-2],
    [1,2],
    [1,-2],
    [2,1],
    [2,-1]
  ]

  def valid_moves
    moves = []
    pos = @root.value

    MOVES.each do |move|
      new_move = []
      new_move << pos[0] + move[0]
      new_move << pos[1] + move[1]

      if on_board?(new_move) && !@visited_positions.include?(new_move)
        moves << new_move
        @visited_positions << new_move
      end
    end

    moves
  end

  def build_move_tree
    valid_moves.each do |move|
      node = PolyTreeNode.new(move)
      node.parent = @root
    end

    @root.children.each do |child|
      child.build_move_tree
    end
  end

  private
  def on_board?(pos)
    (0..8).cover?(pos[0]) && (0..8).cover?(pos[1])
  end
end
