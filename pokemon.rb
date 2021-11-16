require_relative "command"

class Pokemon
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def display(whose_command)
    whose_command.each.with_index(1) do |command, index|
      puts "#{index}. #{command.waza} / いりょく: #{command.damage} "
    end
  end
end