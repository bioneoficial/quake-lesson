# frozen_string_literal: true

require 'rspec'
require_relative '../Game'
require_relative '../game_parser'

describe Game do
  let(:game) { Game.new }
  let(:line) { '2:22 Kill: 3 2 10: Isgalamido killed Dono da Bola by MOD_RAILGUN' }

  describe '#initialize' do
    it 'creates a new game instance' do
      expect(game).to be_an_instance_of(Game)
    end
  end
  describe '#process_kill' do
    it 'increments total_kills by 1' do
      expect { game.process_kill(line) }.to change { game.total_kills }.by(1)
    end

    it 'adds the killer and victim to the players array' do
      game.process_kill(line)
      expect(game.players['Isgalamido']).to be_an_instance_of(Player)
      expect(game.players['Dono da Bola']).to be_an_instance_of(Player)
    end

    it 'increments the kill count for the killer' do
      game.process_kill(line)
      expect(game.kills['Isgalamido']).to eq(1)
    end

    it 'sets the kill count for the victim to 0' do
      game.process_kill(line)
      expect(game.kills['Dono da Bola']).to eq(0)
    end

    it 'increments the kill count for the means of death' do
      game.process_kill(line)
      expect(game.kills_by_means['MOD_RAILGUN']).to eq(1)
    end

    it 'decrements the kill count for the victim if the killer is <world>' do
      game.process_kill(line)
      expect(game.kills['Dono da Bola']).to eq(0)
    end

    it 'increments the kill count for the killer if the killer is not <world>' do
      game.process_kill(line)
      expect(game.kills['Isgalamido']).to eq(1)
    end

    it 'does not increment the kill count for the killer if the killer is the victim' do
      game.process_kill(line)
      expect(game.kills['Isgalamido']).to eq(1)
    end

    it 'does not increment the kill count for the victim if the killer is <world>' do
      game.process_kill(line)
      expect(game.kills['Dono da Bola']).to eq(0)
    end
  end
end
