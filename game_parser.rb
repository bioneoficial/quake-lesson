# frozen_string_literal: true

require_relative 'means_of_death'
require_relative 'game'
class GameParser
  attr_accessor :games, :kills_by_means

  def initialize
    @games = {}
    @game_count = 0
    @kills_by_means = {}
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
    File.open(file_name, 'w') do |file|
      @games.each do |game_id, game|
        file.puts "Game #{game_id}:"
        file.puts "Total kills: #{game.total_kills}"
        file.puts "Players: #{game.players.map { |_, player| player.name }.join(', ')}"
        game.kills.each do |player, kills|
          file.puts "#{player} killed #{kills} players"
        end
        file.puts "\n"
      end
    end
  end

  def print_games_report
    @games.each do |game_id, game|
      puts "Game #{game_id}:"
      puts "Total kills: #{game.total_kills}"
      puts "Players: #{game.players.map { |_, player| player.name }.join(', ')}"
      game.kills.each do |player, kills|
        puts "#{player} killed #{kills} players"
      end
      puts "\n"
    end
  end

  def write_means_of_death_report(file_name)
    File.open(file_name, 'w') do |file|
      @games.each do |game_id, game|
        file.puts "Game #{game_id}:"
        game.kills_by_means.each do |means_of_death, count|
          file.puts "#{means_of_death}: #{count}" if means_of_death
        end
        file.puts "\n"
      end
    end
  end

  def print_means_of_death_report
    @games.each do |game_id, game|
      puts "Game #{game_id}:"
      game.kills_by_means.each do |means_of_death, count|
        puts "#{means_of_death}: #{count}" if means_of_death
      end
      puts "\n"
    end
  end
end
