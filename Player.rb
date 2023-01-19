# frozen_string_literal: true

class Player
  attr_accessor :name, :kills

  def initialize(name)
    @name = name
    @kills = 0
  end

  def increment_kill
    @kills += 1
  end
end
