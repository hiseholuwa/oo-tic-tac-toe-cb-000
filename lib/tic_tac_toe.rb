class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move (index, value = "X")
    @board[index] = value
    display_board
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " " || @board[index] == "")
  end

  def valid_move?(index)
    if index.between?(0,8)
      !(position_taken?(index))
    else
      return false
    end
  end

  def turn_count
    counter = 0
    @board.each do |turns|
      if turns != " " && turns != ""
        counter += 1
      end
    end
    return counter
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    value = current_player
    if !(valid_move?(index))
        turn
    else
      move(index, value)
    end
  end

  def won?
    WIN_COMBINATIONS.each do |index|
      win_combination = []
      index.each do |win_index|
        win_combination.push(@board[win_index])
        if (win_combination == ["X","X","X"]) || (win_combination == ["O","O","O"])
          return index
        end
      end
    end
    return false
  end

  def full?
    !(@board.include?(" "))
  end

  def draw?
    won = won?
    full = full?
    if !won && full
      return true
    elsif won || full
      return false
    end
  end

  def over?
    if won? || full? || draw?
      return true
    else
      return false
    end
  end

  def winner
    index = won?
    if index != false
      if @board[index[0]] == "X"
        return "X"
      elsif @board[index[0]] == "O"
        return "O"
      end
    else
      return nil
    end
  end

  def play
    until over?
      turn
    end
    if won?
      value = winner
      puts "Congratulations #{value}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
