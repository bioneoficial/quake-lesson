require_relative 'game'
require_relative 'game_parser'
#TASK1
parser = GameParser.new
ted =  parser.parse('games.log')
ted.each do |game_id, game|
  puts "Game #{game_id}:"
  puts "Total kills: #{game.total_kills}"
  puts "Players: #{game.players.join(', ')}"
  game.kills.each do |player, kills|
    puts "#{player} killed #{kills} players"
  end
  puts "\n"
end
File.open("task1.txt", "w") do |file|
  ted.each do |game_id, game|
    file.puts "Game #{game_id}:"
    file.puts "Total kills: #{game.total_kills}"
    file.puts "Players: #{game.players.join(', ')}"
    game.kills.each do |player, kills|
      file.puts "#{player} killed #{kills} players"
    end
    file.puts "\n"
  end
end

