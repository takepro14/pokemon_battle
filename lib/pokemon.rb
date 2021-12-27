require_relative "command"
# require "csv"

class Pokemon
  attr_reader :name, :command_csv, :speed
  attr_accessor :hp, :exp_point, :level

  def initialize(name:, command_csv:, exp_point:, level:, hp:, speed:)
    @name = name
    @command_csv = command_csv
    @exp_point = exp_point.to_i
    @level = level.to_i
    @hp = "▓" * hp.to_i
    @speed = speed.to_i
  end

  # ポケモンのステータス情報をCSVからインポート
  def self.import(path:)
    CSV.read(path, headers: true).map do |row|
      Pokemon.new(
        name: row["name"],
        command_csv: row["command_csv"],
        exp_point: row["exp_point"],
        level: row["level"],
        hp: row["hp"],
        speed: row["speed"]
      )
    end
  end

  # ポケモンのコマンド情報をCSVからインポート
  def set_command(csv_path)
    Command.import(path: csv_path)
  end

  # ポケモンのステータスを表示
  def display_status(pokemon_name, pokemon_level, pokemon_hp, pokemon_exp_point)
    # puts "★" * battle_cnt
    puts "*" * 30
    puts "■ #{pokemon_name}"
      # binding.pry
      if pokemon_hp.empty?
        puts "Lv.#{pokemon_level} | HP ひんし"
      else
        puts "Lv.#{pokemon_level} | HP #{pokemon_hp}"
      end
    puts "|" * pokemon_exp_point
    puts "*" * 30
    puts ""
    puts ""
  end

  # ポケモンのわざを表示
  def display_command(pokemon_name, commands)
    puts "<#{pokemon_name} の わざ>"
    commands.each.with_index(1) do |command, index|
      if command.unlocked == "Y"
        puts "#{index}. #{command.waza} / いりょく: #{command.damage} "
      end
    end
  end
end