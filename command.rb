# ポケモンの名前に紐づくコマンド(わざ, ダメージ)をインポートするのみ
require "csv"

class Command
  attr_reader :waza, :damage, :chomp

  def initialize(waza:, damage:, chomp:)
    @waza = waza
    @damage = damage
    @chomp = chomp
  end

  def self.import(path:)
      CSV.read(path, headers: true).map do |row|
        Command.new(
          waza: row["waza"],
          damage: row["damage"].to_i,
          chomp: row["chomp"]
        )
      end
  end

end