require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    move = play_winning_move(node, mark) || play_non_losing_move(node, mark)
    raise "Holy crap, we lost!" unless move
    move
  end

  def play_winning_move(node, mark)
    node.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end

    nil
  end

  def play_non_losing_move(node, mark)
    node.children.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end

    nil
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
