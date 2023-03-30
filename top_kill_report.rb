# frozen_string_literal: true

class TopKillReport
  def initialize(games)
    @games = games
    @players = {}
  end

  def generate
    @games.each do |_game_id, game|
      game.players.each do |name, player|
        if @players.key?(name)
          @players[name].kills += player.kills
        else
          @players[name] = player
        end
      end
    end
    @players = @players.sort_by { |_name, player| player.kills }.reverse
  end

  def write_to_file(file_name)
    File.open(file_name, 'w') do |file|
      file.puts 'Ranking of total kills per player:'
      @players.each do |_name, player|
        file.puts "#{player.name} - #{player.kills} kills"
      end
    end
  end

end
