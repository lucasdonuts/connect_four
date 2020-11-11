class Board
  attr_accessor :board
  def initialize
    @board = Array.new(7) { Array.new(6) }
  end

  def display_board
    0.upto(5) do |i|
      print "|"
      0.upto(6) do |n|
        print @board[n][i].nil? ? "   |" : " #{@board[n][i]} |"
      end
      puts
    end
  end

  def valid_move?(column)
    (1..7).include?(column) && column_not_full?(column)
  end

  def column_not_full?(column)
    @board[column-1].include?(nil)
  end

  def drop_piece(piece, column)
    cell = @board[column - 1].count(nil) - 1
    @board[column - 1][cell] = piece
  end

  def win?
    if four_in_a_row? || four_in_a_column? || four_diagonal?
      return true
    else
      false
    end
  end

  def draw?
    draw = false
    @board.each do |column|
      draw = true if column.none? {|cell| cell.nil?}
    end
    draw
  end

  def four_in_a_row?
    0.upto(5) do |y|
      0.upto(3) do |x|
        if @board[x][y] == @board[x + 1][y] && @board[x][y] == @board[x + 2][y] && @board[x][y] == @board[x + 3][y]
          return true unless @board[x][y].nil?
        end
      end
    end
    false
  end

  def four_in_a_column?
    0.upto(6) do |x|
      0.upto(2) do |y|
        if @board[x][y] == @board[x][y + 1] && @board[x][y] == @board[x][y + 2] && @board[x][y] == @board[x][y + 3]
          return true unless @board[x][y].nil?
        end
      end
    end
    false
  end

  def four_diagonal?
    0.upto(2) do |x|
      0.upto(3) do |y|
        if @board[x][y] == @board[x+1][y+1] && @board[x][y] == @board[x+2][y+2] && @board[x][y] == @board[x+3][y+3]
          return true unless @board[x][y].nil?
        end
      end
    end
    6.downto(3) do |x|
      0.upto(3) do |y|
        if @board[x][y] == @board[x-1][y+1] && @board[x][y] == @board[x-2][y+2] && @board[x][y] == @board[x-3][y+3]
          return true unless @board[x][y].nil?
        end
      end
    end
    false
  end
end