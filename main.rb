require_relative 'game'
require_relative 'game_parser'
require_relative 'top_kill_report'
#TASK1

ted = GameParser.new
ted.parse('games.log')
ted.write_games_report('games_report.txt')


#Task 2
report_kill = TopKillReport.new(ted.parse('games.log'))
report_kill.generate
report_kill.write_to_file("top_kills_report.txt")


#Task 3
ted.write_means_of_death_report("means_of_death_report.txt")

#Task 4