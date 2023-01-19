# frozen_string_literal: true

require 'rspec'
require_relative '../player'

describe Player do
  let(:player0) { Player.new('player0') }
  let(:player1) { Player.new('player1') }

  describe 'initialize player' do
    it 'new player instance' do
      expect(Player.new('new player')).to be_an_instance_of(Player)
    end
  end

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

  describe '#decrement_kill' do
    it 'decrements kills by 1' do
      expect { player0.decrement_kill }.to change { player0.kills }.by(-1)
    end

    it 'decrements kills by 10' do
      10.times { player1.decrement_kill }
      expect(player1.kills).to eq(-10)
    end

    it 'decrements kills by a random number' do
      random_number = rand(1..20)
      random_number.times { player1.decrement_kill }
      expect(player1.kills).to eq(-random_number)
    end

    it 'decrements kills to a negative number' do
      player1.kills = 0
      player1.decrement_kill
      expect(player1.kills).to eq(-1)
    end
  end

  describe '#name' do
    it 'returns player name' do
      expect(player0.name).to eq('player0')
    end

    it 'updates the player name' do
      player0.name = 'new_name'
      expect(player0.name).to eq('new_name')
    end
  end

  describe '#kills' do
    it 'returns player kills' do
      expect(player0.kills).to eq(0)
    end
  end
end
