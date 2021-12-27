# ポケモンの名前に紐づくコマンド(わざ, ダメージ)をインポートするのみ
# require "csv"

class Command
  attr_reader :waza, :damage, :chomp
  attr_accessor :unlocked

  def initialize(waza:, damage:, chomp:, unlocked:)
    @waza = waza
    @damage = damage
    @chomp = chomp
    @unlocked = unlocked
  end

  def self.import(path:)
      CSV.read(path, headers: true).map do |row|
        Command.new(
          waza: row["waza"],
          damage: row["damage"].to_i,
          chomp: row["chomp"],
          unlocked: row["unlocked"]
        )
      end
  end

end