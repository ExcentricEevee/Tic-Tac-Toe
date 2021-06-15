
class Board
    attr_accessor :squares
    WIN_CONDITIONS = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
        [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]  ] 

    def initialize
        @squares = Array.new(9, ' ')
    end

    def show
        puts <<-HEREDOC

         #{squares[0]} | #{squares[1]} | #{squares[2]}
        ---+---+---
         #{squares[3]} | #{squares[4]} | #{squares[5]}
        ---+---+---
         #{squares[6]} | #{squares[7]} | #{squares[8]}

        HEREDOC
    end

    def mark_square(index, player_mark)
        #shift from human-readable 1-9 to array-indexing 0-8
        index = index - 1
        squares[index] = player_mark
    end

    #This is kinda scuffed, maybe refactor this; doesn't account for ties yet
    def game_over?
        WIN_CONDITIONS.any? do |condition|
            #Make sure it's all marks and not spaces
            if [squares[condition[0]], squares[condition[1]], squares[condition[2]]].uniq.include? ' '
                false
            else
                #They should be all the same mark
                [squares[condition[0]], squares[condition[1]], squares[condition[2]]].uniq.length == 1
            end
        end
    end

    def full?
        squares.all? { |square| square != ' '}
    end

    def clear
        initialize
    end
end