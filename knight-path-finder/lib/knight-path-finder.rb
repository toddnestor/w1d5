require_relative '00_tree_node'

class KnightPathFinder
  def initialize(pos,size=9)
    @size = size
    raise unless on_board?(pos)
    @root = PolyTreeNode.new(pos)
    @visited_positions = [pos]
    # build_move_tree
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

  def valid_moves(pos)
    moves = []

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
    queue = [@root]
    until queue.empty?
      next_item = queue.shift
      valid_moves(next_item.value).each do |move|
        node = PolyTreeNode.new(move)
        node.parent = next_item
        queue << node
      end
    end
  end

  def find_path(end_pos)
    raise unless on_board?(end_pos)

    queue = [@root]
    found_node = nil

    until queue.empty? || found_node
      next_item = queue.shift
      if next_item.value == end_pos
        found_node = next_item
      else
        valid_moves(next_item.value).each do |move|
          node = PolyTreeNode.new(move)
          node.parent = next_item
          queue << node
        end
      end
    end

    moves = []

    until found_node.nil?
      moves << found_node.value
      found_node = found_node.parent
    end

    moves.reverse
  end

  private
  def on_board?(pos)
    end_num = @size - 1
    (0..end_num).cover?(pos[0]) && (0..end_num).cover?(pos[1])
  end
end

if __FILE__ == $PROGRAM_NAME
  knight = KnightPathFinder.new([0,0],9)

  if ARGV[0]
    pos = ARGV[0].split(',').map(&:to_i)
  end

  pos ||= [7,2]

  p knight.find_path(pos)
end
