require './game_parser'
require_relative 'player'
class Game
  attr_accessor :total_kills, :players, :kills

  def initialize
    @total_kills = 0
    @players = {}
    @kills = {}
  end

  def process_kill(line)
    match = line.match(/(?<timestamp>\S+).*Kill: (?<killer_id>\S+) (?<killed_id>\S+) (?<means_of_death_id>\d+): (?<killer_name>\S+) killed (?<victim_name>.+) by (?<means_of_death>\S+)/)
    @total_kills += 1
    add_player(match[:killer_name]) unless @players.key?(match[:killer_name]) || match[:killer_name] == '<world>'
    add_player(match[:victim_name]) unless @players.key?(match[:victim_name])
    increment_kill(match[:killer_name]) if match[:killer_name] != '<world>' && match[:killer_name] != match[:victim_name]
    decrement_kill(match[:victim_name]) if match[:killer_name] == '<world>'
  end

  private

  def add_player(player_name)
    @players[player_name] = Player.new(player_name)
    @kills[player_name] = 0
  end

  def increment_kill(killer_name)
    @players[killer_name].increment_kill
    @kills[killer_name] += 1
  end

  def decrement_kill(victim_name)
    @players[victim_name].decrement_kill
    @kills[victim_name] -= 1
  end
end