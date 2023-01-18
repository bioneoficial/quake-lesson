require './game_parser'
class Game
  attr_accessor :total_kills, :players, :kills

  def initialize
    @total_kills = 0
    @players = []
    @kills = {}
  end

  def process_kill(line)
    match = line.match(/(?<timestamp>\S+).*Kill: (?<killer_id>\S+) (?<killed_id>\S+) (?<means_of_death_id>\d+): (?<killer_name>\S+) killed (?<victim_name>.+) by (?<means_of_death>\S+)/)
    @total_kills += 1

    add_player(match[:killer_name]) unless @players.include?(match[:killer_name]) || match[:killer_name] == '<world>'
    add_player(match[:victim_name]) unless @players.include?(match[:victim_name])

    increment_kill(match[:killer_name], match[:victim_name]) if match[:killer_name] != '<world>' && match[:killer_name] != match[:victim_name]
  end

  private

  def add_player(player)
    @players << player
    @kills[player] = 0
  end

  def increment_kill(killer, victim)
    @kills[victim] = 0 unless @kills.key?(victim)
    @kills[killer] += 1
  end
end

# class GameParser
#   attr_accessor :games
#
#   def initialize
#     @games = {}
#     @game_count = 0
#   end
#
#   def parse(file)
#     File.foreach(file).slice_after(/InitGame/).slice_before(/ShutdownGame/ || /-{60}/).map do |game_lines|
#       game_lines.select do |line|
#         line.map do |line|
#           if line.match(/InitGame/)
#             @game_count += 1
#             @games[@game_count] = Game.new
#           elsif line.match(/(?<timestamp>\S+).*Kill: (?<killer_id>\S+) (?<killed_id>\S+) (?<means_of_death_id>\d+): (?<killer_name>\S+) killed (?<victim_name>.+) by (?<means_of_death>\S+)/)
#             @games[@game_count].process_kill(line)
#           end
#         end
#       end
#     end
#
#     @games.reject! { |game_id, game_data| game_data.players.empty? }
#   end
# end

parser = GameParser.new
ted =  parser.parse('games.log')
#TASK1
ted.each do |game_id, game|
  puts "Game #{game_id}:"
  puts "Total kills: #{game.total_kills}"
  puts "Players: #{game.players.join(', ')}"
  game.kills.each do |player, kills|
    puts "#{player} killed #{kills} players"
  end
  puts "\n"
end
#TASK1
# File.open("game_results.txt", "w") do |file|
#   ted.each do |game_id, game|
#     file.puts "Game #{game_id}:"
#     file.puts "Total kills: #{game.total_kills}"
#     file.puts "Players: #{game.players.join(', ')}"
#     game.kills.each do |player, kills|
#       file.puts "#{player} killed #{kills} players"
#     end
#     file.puts "\n"
#   end
# end

