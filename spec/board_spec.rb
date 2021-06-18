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
    end
end