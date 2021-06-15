#***Original TicTacToe game made before learning about testing and TDD
#Made the decision to completely remake the game, using better OO design as it should be
#I have left the file here for...archival I guess. The new game is in /lib/

require_relative '../lib/player'

class Board
  attr_accessor :board, :player1, :player2

  def initialize(p1, p2)
    #Refactored to be one 9-length array that is displayed 3 chunks at a time
    @board = Array.new(9, " ")
    #Player objects created here so they can interact with Board
    #Mark to be made as a choice later, for now it's hard coded
    @player1 = p1
    @player2 = p2
  end

  def startup
    player1.get_name
    player1.get_mark
    player2.get_name
    if player1.mark == "X"
      puts "#{player1.name} chose #{player1.mark}, so you have to be O."
      player2.mark = "O"
    else
      puts "#{player1.name} chose #{player1.mark}, so you have to be X."
      player2.mark = "X"
    end
  end

  def display_board
    puts ""
    puts " #{board[0]} | #{board[1]} | #{board[2]}"
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]}"
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]}"
    puts ""
  end

  def clear_board
    #doesn't work without the @ even though I have the getter method set up?? whatalksdjf
    @board = Array.new(9, " ")
  end

  def play_game
    turns = 0
    player1_played_last = false
    player2_played_last = false
    win = false

    while turns < 9 do
      if (player1_played_last)
        win = place_mark(player2)
        player2_played_last = true
        player1_played_last = false
      #using else instead of elsif b/c if this is the first move, Player1 will go first every time
      else
        win = place_mark(player1)
        player1_played_last = true
        player2_played_last = false
      end

      if win == true
        break
      end
      turns += 1
    end

    if win == false 
      puts "Tie! The board will now clear."
    end
  end

  private

  def check_win(player)
    #horizontals
    if (board[0] == player.mark && board[1] == player.mark && board[2] == player.mark) ||
       (board[3] == player.mark && board[4] == player.mark && board[5] == player.mark) ||
       (board[6] == player.mark && board[7] == player.mark && board[8] == player.mark) ||
    #verticals
       (board[0] == player.mark && board[3] == player.mark && board[6] == player.mark) ||
       (board[1] == player.mark && board[4] == player.mark && board[7] == player.mark) ||
       (board[2] == player.mark && board[5] == player.mark && board[8] == player.mark) ||
    #diagonal
       (board[0] == player.mark && board[4] == player.mark && board[8] == player.mark) ||
       (board[2] == player.mark && board[4] == player.mark && board[6] == player.mark)
      puts "#{player.mark} wins this round!"
      player.score += 1
      puts "#{player1.name}'s Score: #{player1.score}       #{player2.name}'s Score: #{player2.score}"
      return true
    else
      return false
    end
  end

  #This feels like a method Player would use, but I dunno how to do that without losing scope of Board
  #Needs to accommodate no-repeat moves; ask the player to go again if they make an illegal move
  def place_mark(player)
    acceptable = false
    until (acceptable)
      print "#{player.name} (#{player.mark}), place your mark: "
      choice = gets.chomp
      if (choice.to_i >= 1 && choice.to_i <= 9)
        if (board[choice.to_i-1] == " ")
          acceptable = true
        else
          puts "This spot is already taken. Please choose another."
        end
      elsif (choice.downcase == "exit")
        exit
      else
        puts "Please enter a number between 1 and 9."
      end
    end

    board[choice-1] = player.mark
    display_board
    check_win(player)
  end
end

puts "Welcome to Tic Tac Toe!\n\n"
puts "Before we begin, let's get your names and symbols."
board = Board.new(Player.new, Player.new)
board.startup

board.display_board
loop do
  board.clear_board
  board.play_game
end
