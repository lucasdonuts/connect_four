require_relative "player.rb"
require_relative "board.rb"

class ConnectFour
  attr_reader :board, :player1, :player2, :current_player
  def initialize
    @board = Board.new
    @player1 = Player.new("Player 1", "X")
    @player2 = Player.new("Player 2", "O")
    @current_player = @player1
    game_loop
  end

  def game_loop
    puts "Welcome to Connect Four!"
    loop do
      @board.display_board
      puts "#{@current_player.name} choose a column (1-7) to make your move."
      column = get_move
      @board.drop_piece(@current_player.piece, column)
      check_game_over
      switch_current_player
    end
  end

  def get_move
    choice = gets.chomp.to_i
    if !@board.column_not_full?(choice)
      puts "That column is filled. Try again."
      get_move
    elsif !@board.valid_move?(choice)
      puts "Out of bounds. Choice must be between 1 and 7."
      get_move
    end
    choice
  end

  def switch_current_player
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def win_message
    puts "Congratulations #{@current_player.name}, you win!"
    @board.display_board
    reset_game
  end

  def draw_message
    puts "Looks like we have a draw!"
    @board.display_board
    reset_game
  end

  def check_game_over
    if @board.win?
      win_message
    elsif @board.draw?
      draw_message
    end
  end

  def play_again?
    puts "Would you like to play again? (y/n)"
    input = gets.chomp
    if input == "y"
      return true
    elsif input == "n"
      return false
    else
      puts "Invalid input."
      play_again?
    end
  end

  def reset_game
    if play_again?
      ConnectFour.new
    else
      exit
    end
  end
end

game = ConnectFour.new