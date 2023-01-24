# frozen_string_literal: true

class GamesReportWriter
  def initialize(games)
    @games = games
  end

  def write_games_report(file_name)
    File.open(file_name, 'w') do |file|
      @games.each do |game_id, game|
        file.puts " game_#{game_id}: {"
        file.puts "   total_kills: #{game.total_kills};"
        file.puts "   players: [#{game.players.map { |_, player| "\"#{player.name}\"" }.join(', ')}]"
        file.puts '   kills: {'
        game.kills.each do |player, kills|
          file.puts "     \"#{player}\":  #{kills}"
        end
        file.puts '   }'
        file.puts '}'
        file.puts "\n"
      end
    end
  end
end
