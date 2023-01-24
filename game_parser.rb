# frozen_string_literal: true

require_relative 'means_of_death'
require_relative 'game'
require_relative 'games_report_writer'
require_relative 'means_of_death_report_writer'

class GameParser
  attr_accessor :games, :kills_by_means

  def initialize
    @games = {}
    @game_count = 0
    @kills_by_means = {}
    @games_report = {}
    @means_report = {}
  end

  def parse(file)
    File.open(file, 'r') do |file_opened|
      file_opened.each_line.slice_after(/InitGame/).map do |game_lines|
        process_game_lines(game_lines)
      end
    end
    @games.reject! { |_game_id, game_data| game_data.players.empty? }
  end

  def process_game_lines(game_lines)
    game_lines.select do |line|
      if line.match(/InitGame/)
        @game_count += 1
        @games[@game_count] = Game.new
      elsif line.match(/(?<timestamp>\S+).*Kill: (?<killer_id>\S+) (?<killed_id>\S+) (?<means_of_death_id>\d+): (?<killer_name>\S+) killed (?<victim_name>.+) by (?<means_of_death>\S+)/)
        @games[@game_count].process_kill(line)
      end
    end
  end

  def write_games_report(file_name)
    GamesReportWriter.new(@games).write_games_report(file_name)
  end

  def write_means_of_death_report(file_name)
    MeansOfDeathReportWriter.new(@games).write_means_of_death_report(file_name)
  end
end
