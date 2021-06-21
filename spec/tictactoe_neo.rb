require_relative '../lib/tictactoe_neo'
require_relative '../lib/board'
require_relative '../lib/player'

describe Game do
    #to make contextual game instances with
    let(:p1) { Player.new }
    let(:p2) { Player.new }
    let(:board) { Board.new }
    

    describe '#setup_players' do
        subject(:game) { described_class.new(board, p1, p2) }

        context 'when game receives #setup_players' do
            it 'receives #setup_players' do
                expect(game).to receive(:setup_players)
                game.setup_players
            end

        end

        context 'when getting player information' do
            #let(:player1) { double('player1') }
            
    
            it 'sends a message to #set_name' do
                player = game.p1

                expect(player).to receive(:set_name).once
                game.setup_players
            end
        end
    end

    describe '#switch_current_player' do
        subject(:game) { described_class.new(board, p1, p2) }
        
        context 'when current_player is player1' do
            before do
                game.current_player = p1
                
            end

            it 'should set current_player to player2' do
                game.switch_current_player
                expect(game.current_player).to eq(p2)
            end
        end

        context 'when current_player is player2' do
            before do
                game.current_player = p2
                
            end

            it 'should set current_player to player1' do
                game.switch_current_player
                expect(game.current_player).to eq(p1)
            end
        end

        context 'when current_player is nil' do
            before do
                game.current_player = nil
            end

            it 'should set current_player to player1' do
                game.switch_current_player
                expect(game.current_player).to eq(p1)
            end
        end
    end

    describe '#take_turn' do
        subject(:game) { described_class.new(board, p1, p2) }

        context 'when input looping' do
            let(:player) { instance_double('current_player', mark: 'X') }
            valid_input = '3'


            xit 'stops loop on #verify_input returning true after one call' do
                game.current_player = player
                allow(game).to receive(:verify_input).and_return(false, true)
                expect(game).to receive(:puts).with('Please try again.').once
                expect(game).to receive(:verify_input).and_return(true)
                game.take_turn(valid_input)
            end
        end

        context 'when looping twice' do
            let(:player) { instance_double('current_player', mark: 'O') }
            invalid_input = '11'
            valid_input = '1'

            xit 'returns false once and true once' do
                game.current_player = player
                expect(game).to receive(:verify_input).and_return(false).once
                expect(game).to receive(:verify_input).and_return(true).once
                game.take_turn(valid_input)
            end
        end
    end

    describe '#verify_input' do
        subject(:valid_game) { described_class.new(board, p1, p2) }

        context 'when given a valid input' do
            valid_input = '5'

            it 'should return the input value' do
                expect(valid_game.verify_input(valid_input)).to eq(valid_input)
            end
        end

        context 'when given an invalid input' do
            invalid = 'a'

            it 'should call a #print message' do
                expect(valid_game).to receive(:print).with('This is not a valid input. ')
                valid_game.verify_input(invalid)
            end
        end

        context 'when the selected spot is already taken' do
            before do
                board.squares[0] = 'X'
            end

            duplicate_input = '1'

            it 'should call a #print message' do
                expect(valid_game).to receive(:print).with('This square is taken already. ')
                valid_game.verify_input(duplicate_input)
            end
        end
    end

    describe '#check_for_tie' do
        context 'when the board is full without a winner' do
            let(:player1) { instance_double('Player', mark: 'X', score: 10) }
            let(:player2) { instance_double('Player', mark: 'O', score: 1) }
            subject(:tie_game) { described_class.new(board, player1, player2) }

            it 'ends the game without either player score increasing' do
                allow(board).to receive(:full?).and_return(true)
                allow(board).to receive(:game_over?).and_return(false)
                allow(tie_game).to receive(:show_score)
                allow(tie_game).to receive(:play_again)

                expect(tie_game).to receive(:puts).with('Seems to be a tie!')
                expect(tie_game).to receive(:show_score).once
                expect(tie_game).to receive(:play_again).once

                tie_game.check_for_tie
                expect(player1.score).to eq(10)
                expect(player2.score).to eq(1)
            end
        end

        context 'when the board is full but has a winner' do
            let(:winning_board) { Board.new }
            let(:game) { described_class.new(winning_board, p1, p2) }

            it 'should call #game_win' do
                allow(winning_board).to receive(:full?).and_return(true)
                allow(winning_board).to receive(:game_over?).and_return(true)
                expect(game).to receive(:game_win)
                game.check_for_tie
            end
        end
    end

    describe '#game_win' do
        context 'when a player wins' do
            let(:player) { instance_double('Player', name: 'Kinus', mark: 'X', score: 0) }
            subject(:game) { described_class.new(board, player, p2) }

            #need to figure out how to get :score= to work
            xit 'should increase their score by exactly one' do
                game.current_player = player
                current_score = game.current_player.instance_variable_get(:@score)
                allow(game).to receive(:display_board)
                allow(game).to receive(:puts)
                expect { game.game_win }.to change { current_score }.by(1)
            end
        end
    end
end