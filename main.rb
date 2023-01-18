# frozen_string_literal: true
# items = []
# 	File.foreach('games.log').slice_before(/ShutdownGame/).map do |game_lines|
# 		game_lines.select { |line| line.match(/Item/) }.map do |line|
# 			match = line.match(/(?<timestamp>\S+).*Item: (?<player_id>\S+) (?<weapon>\S+)/)
# 			items << match.named_captures
# 		end.compact
# 	end
# puts items
#-{60}/
match_kill_data = []
games = {}
game_count = 0
File.foreach('test.log').slice_after(/InitGame/).slice_before(/ShutdownGame/ || /-{60}/)
    .map do |game_lines|
  game_lines.select do |line|
    line.map do |line|
      if line.match(/InitGame/)
        game_count += 1
        games[game_count] = { total_kills: 0, players: [], kills: {} }
        elsif line.match(/(?<timestamp>\S+).*Kill: (?<killer_id>\S+) (?<killed_id>\S+) (?<means_of_death_id>\d+): (?<killer_name>\S+) killed (?<victim_name>.+) by (?<means_of_death>\S+)/)
          match = line.match(/(?<timestamp>\S+).*Kill: (?<killer_id>\S+) (?<killed_id>\S+) (?<means_of_death_id>\d+): (?<killer_name>\S+) killed (?<victim_name>.+) by (?<means_of_death>\S+)/)
          games[game_count][:total_kills] += 1
          if !games[game_count][:players].include?(match[:killer_name]) && match[:killer_name] != '<world>'
            games[game_count][:players] << match[:killer_name]
            games[game_count][:kills][match[:killer_name]] = 0
          end
          games[game_count][:players] << match[:victim_name] unless games[game_count][:players].include?(match[:victim_name])
          if match[:killer_name] != '<world>' && match[:killer_name] != match[:victim_name]
            games[game_count][:kills][match[:victim_name]] = 0 unless games[game_count][:kills].key?(match[:victim_name])
            games[game_count][:kills][match[:killer_name]] =
              games[game_count][:kills].key?(match[:killer_name]) ? (games[game_count][:kills][match[:killer_name]] + 1) : 0
          end
        end
    end.compact
  end
end

games.reject! { |game_id, game_data| game_data[:players].empty? }


# for n in games
#   puts n
# end