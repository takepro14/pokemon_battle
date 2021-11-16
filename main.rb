require "pry"
require_relative "pokemon"
require_relative "command"
require_relative "trainer"

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
# binding.pry


# [事前準備] トレーナーを準備
trainer = Trainer.new(TRAINER)
trainer_name = trainer.tr_name

# [事前準備] 敵のHPを準備
enemy_hp = "▓▓▓▓▓▓▓▓▓▓"


# ░, ▓
# ポケモンが現れる（CSVからランダム出現）
puts "あっ！野生の #{this_enemy_name} があらわれた！"
puts "【 #{this_enemy_name} Lv.5 / HP #{enemy_hp} 】"
puts ""
# sleep 1

# こちらのポケモンを繰り出す
puts "#{trainer_name}「いけっ！ #{this_allies_name}！」"
puts "【 #{this_allies_name} Lv.5 / HP ▓▓▓▓▓▓▓▓▓▓ 】"
puts ""

while enemy_hp.include?("▓") do
  # トレーナーの指示出し
  allies.display(allies_command)
  puts ""
  # sleep 1
  print "#{this_allies_name} はどうする？ > "
  command = trainer.choice_command(allies_command)

  # コマンドを実行し、相手ポケモンにダメージ
  puts "#{this_allies_name} の #{command.waza}！"
  puts "#{this_enemy_name} に #{command.damage} のダメージ！"
  puts ""
  if command.waza == "あわ"
    enemy_hp = enemy_hp.chomp("▓▓▓▓") + "░░░░"
  elsif
    command.waza == "バブルこうせん"
    enemy_hp = enemy_hp.chomp("▓▓▓▓▓▓") + "░░░░░░"
  elsif
    command.waza == "しっぽをふる"
    enemy_hp = enemy_hp
  end

  puts "【 #{this_enemy_name} Lv.5 / HP #{enemy_hp} 】"

end

# 倒したとき
"#{this_enemy_name} は たおれた！"
puts "#{this_allies_name} は けいけんちを 5 かくとくした！"



# 相手のポケモンが倒れていなければ、コマンドを実行
# command_enemy = Command.import(path: "hitokage.csv")


# 繰り返し


# 自分/相手のどちらのポケモンが倒れたかでメッセージを出しわけ



