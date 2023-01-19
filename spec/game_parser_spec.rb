# frozen_string_literal: true
require 'rspec'
require_relative '../Game'
require_relative '../player'
require_relative '../game_parser'


describe GameParser do
  let(:parser) { GameParser.new }
  let(:games_file) { 'games.log' }

  describe '#parse' do
    it 'parses the games log and creates a hash of games' do
      expect(parser.parse(games_file)).to be_an_instance_of(Hash)
    end

  end

  describe '#write_games_report' do
    it 'creates a file with the correct report of the games' do
      parser.parse(games_file)
      parser.write_games_report('games_report.txt')
      expect(File.exist?('games_report.txt')).to be true
    end
  end

  describe '#print_games_report' do
    it 'prints the correct report of the games in the terminal' do
      parser.parse(games_file)
      expect { parser.print_games_report }.to output.to_stdout
    end
  end
end




