require_relative 'player'
require_relative 'board'

class Game
    attr_reader :board, :p1, :p2
    attr_accessor :current_player

    def initialize(board, player1, player2)
        #starts with a blank space character to make empty board spaces formatted correctly
        @board = board
        @p1 = player1
        @p2 = player2
        @current_player = nil
    end

    def start
        setup_players
        play
    end

    def play
        until board.game_over? do
            switch_current_player
            take_turn
            check_for_tie
        end

        game_win
    end

    def setup_players
        p1.set_name
        p1.set_mark('X')
        puts "Welcome #{p1.name}, you will play #{p1.mark}."
        gets
        p2.set_name
        p2.set_mark('O')
        puts "Welcome #{p2.name}, you will play #{p2.mark}."
        gets
    end

    def switch_current_player
        current_player == p1 ? self.current_player = p2 : self.current_player = p1
    end

    def take_turn(input = get_player_input)
        #input = nil
        
        #display_board
        loop do
        #    input = get_player_input
        #    break if verify_input(input)
            verify_input(input) ? break : input = get_player_input
            puts "Please try again."
        end



        #Convert to Integer to be used with the squares array in Board
        board.mark_square(input.to_i, current_player.mark)
    end
  
    def get_player_input
        #let the player see what the board is like so they can make an informated choice
        display_board
        puts "#{current_player.mark}, please select a square using 1 to 9:"
        gets.chomp
    end

    #for both regex validation as well as checking for already claimed squares
    def verify_input(input)
        if !(input.match?(/^[1-9]$/))
            print "This is not a valid input. "
        elsif !(board.squares[input.to_i-1] == ' ')
            print "This square is taken already. "
        else
            input
        end
    end

    def check_for_tie
        if board.full?
            if board.game_over?
                game_win
            else
                puts "Seems to be a tie!"
                show_score
                play_again
            end
        end
    end

    def game_win
        display_board
        puts "It looks like #{current_player.name} has won! You get a fancy point."
        current_player.score += 1
        show_score
        play_again
    end

    def show_score
        puts "Right now it's #{p1.name}: #{p1.score} vs #{p2.name}: #{p2.score}\n\n"
    end

    def play_again
        puts "Would you like to play again? (y/n)"
        loop do
            input = gets.chomp
            if input == 'y'
                board.clear
                play
            elsif input == 'n'
                exit
            else
                puts "For the love of god just put 'y' or 'n' sobs"
            end
        end
    end

    def display_board
        board.show
    end
end