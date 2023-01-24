# frozen_string_literal: true

class MeansOfDeathReportWriter
  def initialize(games)
    @games = games
  end

  def write_means_of_death_report(file_name)
    File.open(file_name, 'w') do |file|
      @games.each do |game_id, game|
        file.puts "game-#{game_id}: {"
        file.puts '       kills_by_means: {'
        game.kills_by_means.each do |means_of_death, count|
          file.puts "             \"#{means_of_death}\": #{count}," if means_of_death
        end
        file.puts '       }'
        file.puts '}'
        file.puts "\n"
      end
    end
  end
end
