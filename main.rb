require "pry"
require_relative "pokemon"
require_relative "command"
require_relative "trainer"


# binding.pry

# [事前準備] ポケモンを準備
ENEMY = "ヒトカゲ"
ALLIES = "ゼニガメ"
TRAINER = "たけぴよ"

enemy = Pokemon.new(ENEMY)
this_enemy_name = enemy.name
allies = Pokemon.new(ALLIES)
this_allies_name = allies.name

# [事前準備] ポケモンのわざを準備
allies_command = Command.import(path: "zenigame.csv")

# [事前準備] トレーナーを準備
trainer = Trainer.new(TRAINER)
trainer_name = trainer.tr_name


# ░, ▓
# ポケモンが現れる（CSVからランダム出現）
puts "あっ！野生の #{this_enemy_name} があらわれた！"
puts "【 #{this_enemy_name} Lv.5 / HP ▓▓▓▓▓▓▓▓▓▓ 】"
puts ""
# sleep 1

# こちらのポケモンを繰り出す
puts "#{trainer_name}「いけっ！ #{this_allies_name}！」"
puts "【 #{this_allies_name} Lv.5 / HP ▓▓▓▓▓▓▓▓▓▓ 】"
puts ""
allies.display(allies_command)
puts ""
# sleep 1

# トレーナーの指示出し
print "#{this_allies_name} はどうする？ > "
# binding.pry
trainer.choice_command(allies_command)
# binding.pry

p choice_command

# allies_command["command"]




# puts "#{this_allies_name} はどうする？ > "
# @command_a.each.with_index(1) do |index, command, damage|
#   cmd = "#{index}: #{command} #{damage}"
#   puts cmd
# end



# コマンドを実行し、相手ポケモンにダメージ


# 相手のポケモンが倒れていなければ、コマンドを実行
# command_enemy = Command.import(path: "hitokage.csv")


# 繰り返し


# 自分/相手のどちらのポケモンが倒れたかでメッセージを出しわけ



