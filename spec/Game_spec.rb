require 'rspec'
require_relative '../Game'
require_relative '../game_parser'

describe Game do
  let(:game) { Game.new }
  let(:line) { '2022-09-10 21:23 Kill: 2 3 4: player1 killed player2 by MOD_ROCKET' }

  describe '#process_kill' do
    it 'increments total_kills by 1' do
      expect { game.process_kill(line) }.to change { game.total_kills }.by(1)
    end

    it 'adds the killer and victim to the players array' do
      game.process_kill(line)
      expect(game.players).to match_array(%w[player1 player2])
    end

    it 'increments the kill count for the killer' do
      game.process_kill(line)
      expect(game.kills['player1']).to eq(1)
    end

    it 'sets the kill count for the victim to 0' do
      game.process_kill(line)
      expect(game.kills['player2']).to eq(0)
    end
  end
end
