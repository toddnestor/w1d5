require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return true if @board.winner == get_opposite_mark(evaluator)
      false
    else
      if @next_mover_mark == evaluator
        children.all? {|child| child.losing_node?(evaluator)}
      else
        children.any? {|child| child.losing_node?(evaluator)}
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return true if @board.winner == evaluator
      false
    else
      if @next_mover_mark == evaluator
        children.any? {|child| child.winning_node?(evaluator)}
      else
        children.all? {|child| child.winning_node?(evaluator)}
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    # new_node = node( next_board, next_mark, pos)
    child_states = []

    empty_positions(@board).each do |pos|
      duped_board = @board.dup
      duped_board[pos] = @next_mover_mark
      child_states << TicTacToeNode.new(duped_board, opposite_mark, pos)
    end

    child_states
  end

  def opposite_mark
    get_opposite_mark(@next_mover_mark)
  end

  def get_opposite_mark(mark)
    mark == :x ? :o : :x
  end

  def empty_positions(board)
    positions = []

    (0..2).each do |x|
      (0..2).each do |y|
        new_pos = [x,y]
        positions << new_pos if board.empty?(new_pos)
      end
    end

    positions
  end
end
