require_relative "command"
# require "csv"

class Pokemon
  attr_reader :name, :command_csv, :exp_point, :speed

  def initialize(name:, command_csv:, exp_point:, speed:)
    @name = name
    @command_csv = command_csv
    @exp_point = exp_point
    @speed = speed
  end

  def self.import(path:)
    CSV.read(path, headers: true).map do |row|
      Pokemon.new(
        name: row["name"],
        command_csv: row["command_csv"],
        exp_point: row["exp_point"],
        speed: row["speed"]
      )
    end
  end

  def display(whose_command)
    whose_command.each.with_index(1) do |command, index|
      if command.unlocked == "Y"
        puts "#{index}. #{command.waza} / いりょく: #{command.damage} "
      end
    end
  end
end