# frozen_string_literal: true

require 'rspec'
require_relative '../player'

describe Player do
  let(:player0) { Player.new('player0') }
  let(:player1) { Player.new('player1') }

  describe '#increment_kill' do
    it 'increments kills by 1' do
      expect { player0.increment_kill }.to change { player0.kills }.by(1)
    end

    it 'increments kills by 10' do
      10.times { player1.increment_kill }
      expect(player1.kills).to eq(10)
    end

    it 'increments kills by a random number' do
      random_number = rand(1..20)
      random_number.times { player1.increment_kill }
      expect(player1.kills).to eq(random_number)
    end
  end
end
