require_relative "command"
# require "csv"

class Pokemon
  attr_reader :name, :command_csv, :exp_point

  def initialize(name:, command_csv:, exp_point:)
    @name = name
    @command_csv = command_csv
    @exp_point = exp_point
  end

  def self.import(path:)
    CSV.read(path, headers: true).map do |row|
      Pokemon.new(
        name: row["name"],
        command_csv: row["command_csv"],
        exp_point: row["exp_point"]
      )
    end
  end

  def display(whose_command)
    whose_command.each.with_index(1) do |command, index|
      puts "#{index}. #{command.waza} / いりょく: #{command.damage} "
    end
  end
end