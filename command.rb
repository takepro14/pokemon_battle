# わざ, ダメージをインポートするのみ
require "csv"

class Command
  attr_reader :waza, :damage

  def initialize(waza:, damage:)
    @waza = waza
    @damage = damage
  end

  def self.import(path:)
      CSV.read(path, headers: true).map do |row|
        Command.new(
          waza: row["waza"],
          damage: row["damage"].to_i
        )
      end
  end

end