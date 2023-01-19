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
    # @kills[victim] = 0 unless @kills.key?(victim)
    @kills[killer] += 1
  end
end