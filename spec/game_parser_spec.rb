# frozen_string_literal: true

require 'rspec'
require_relative '../Game'
require_relative '../player'
require_relative '../game_parser'
require 'tempfile'
require_relative '../top_kill_report'

describe GameParser do
  let(:parser) { GameParser.new }
  let(:file) { double(:file) }
  let(:games_file) { 'games.log' }

  describe 'Creates new GameParser instance' do
    it 'creates a new GameParser instance' do
      expect(GameParser.new).to be_an_instance_of(GameParser)
    end
  end
  describe '#parse' do
    it 'parses the games log and creates a hash of games' do
      expect(parser.parse(games_file)).to be_an_instance_of(Hash)
    end

    it 'should remove games with no players' do
      allow(File).to receive(:open).with(file, 'r').and_yield(file)
      allow(file).to receive(:each_line).and_return([])
      allow(parser).to receive(:process_game_lines)
      parser.parse(file)
      expect(parser.games).to receive(:reject!)
      parser.parse(file)
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

  describe '#write_games_report' do
    it 'should write the games report to a file' do
      file_name = 'games_report.txt'
      expect(File).to receive(:open).with(file_name, 'w')
      parser.write_games_report(file_name)
    end
  end

  describe '#write_means_of_death_report' do
    it 'should write the means of death report to a file' do
      file_name = 'means_of_death_report.txt'
      expect(File).to receive(:open).with(file_name, 'w')
      parser.write_means_of_death_report(file_name)
    end
  end
end
