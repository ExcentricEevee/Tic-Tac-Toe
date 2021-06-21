require_relative '../lib/board.rb'

describe Board do
    describe '#game_over?'do
        context 'when there is a winning combination' do
            winning_array = ['X', 'O', 'X', 'O', 'X', 'O', 'X', ' ', ' ']
            subject(:winning_board) { described_class.new}


            it 'returns true' do
                winning_board.squares = winning_array
                expect(winning_board.game_over?).to eq(true)
            end
        end

        context 'when the player mark is something other than X or O' do
            winning_array = ['L', 'O', 'L', 'O', 'L', 'O', 'L', ' ', ' ']
            subject(:winning_board) { described_class.new}


            it 'still returns true' do
                winning_board.squares = winning_array
                expect(winning_board.game_over?).to eq(true)
            end
        end

        context 'when there are empty spaces in the conditional check' do
            spotted_array = ['X', 'O', 'X', 'O', ' ', 'O', 'X', ' ', ' ']
            subject(:board) { described_class.new }

            it 'returns false' do
                board.squares = spotted_array
                expect(board.game_over?).to eq(false)
            end
        end
    end

    describe '#mark_square' do
        context 'when index is 5' do
            subject(:board) { described_class.new }

            it 'puts the player mark in square[4]' do
                expect { board.mark_square(5, 'X') }.to change { board.squares[4] }.to('X')
            end
        end
    end
end