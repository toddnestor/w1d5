require_relative 'n-tree'

class KPFNTree
  def initialize(pos)
    raise unless on_board?(pos)
    @tree = NTree.new(8)
    @tree.add(pos)
    # build_move_tree
  end

  def tree
    @tree
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

      if on_board?(new_move) && !@tree.include?(new_move)
        moves << new_move
      end
    end

    moves
  end

  def build_move_tree
    queue = [0]
    until queue.empty?
      next_item = queue.shift
      valid_moves(@tree[next_item]).each do |move|
        node = @tree.add(move, next_item)
        queue << node unless queue.include?(node)
      end
    end
  end

  def find_path(end_pos)
    raise unless on_board?(end_pos)

    @tree.each_with_index do |item, idx|
      return @tree.path(idx) if item == end_pos

      if item
        valid_moves(item).each do |move|
          node = @tree.add(move, idx)
        end
      end
    end

    nil
  end

  private
  def on_board?(pos)
    (0..8).cover?(pos[0]) && (0..8).cover?(pos[1])
  end
end

if __FILE__ == $PROGRAM_NAME
  knight = KPFNTree.new([0,0])

  if ARGV[0]
    pos = ARGV[0].split(',').map(&:to_i)
  end

  pos ||= [7,2]

  p knight.find_path(pos)
end
