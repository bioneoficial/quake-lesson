
class GameParser
  attr_accessor :games

  def initialize
    @games = {}
    @game_count = 0
  end

  def parse(file)
    File.foreach(file).slice_after(/InitGame/).slice_before(/ShutdownGame/ || /-{60}/).map do |game_lines|
      game_lines.select do |line|
        line.map do |line|
          if line.match(/InitGame/)
            @game_count += 1
            @games[@game_count] = Game.new
          elsif line.match(/(?<timestamp>\S+).*Kill: (?<killer_id>\S+) (?<killed_id>\S+) (?<means_of_death_id>\d+): (?<killer_name>\S+) killed (?<victim_name>.+) by (?<means_of_death>\S+)/)
            @games[@game_count].process_kill(line)
          end
        end
      end
    end

    @games.reject! { |game_id, game_data| game_data.players.empty? }
  end
end
