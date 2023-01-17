# frozen_string_literal: true

class QuakeParser
  attr_accessor :file_name

  def initialize(file_name)
    @file_name = file_name
  end
  def parse(file_name)
    @@file_log = File.open(file_name, 'r')
    @@file_log.slice_after(/InitGame/)
              .slice_before(/ShutdownGame/ || /-{60}/)
              .map do |game_lines|
      game_lines.select do |line|
        line.map do |line|
          if line.match(/InitGame/)
            oi = line.match(/InitGame/)
            puts oi
          end
        end.compact
      end
    end
  end
end
oi = QuakeParser.new('test.log')
oi.parse('test.log')
