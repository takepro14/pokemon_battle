require "pry"
require_relative "pokemon"
require_relative "command"
require_relative "trainer"

# binding.pry

#############################
# 変数, インスタンス生成
#############################
# ポケモンを準備
ENEMY = "ヒトカゲ"
ALLIES = "ゼニガメ"
TRAINER = "たけぴよ"

enemy = Pokemon.new(ENEMY)
this_enemy_name = enemy.name
allies = Pokemon.new(ALLIES)
this_allies_name = allies.name

# ポケモンのわざを準備
allies_command = Command.import(path: "zenigame.csv")

# トレーナーを準備
trainer = Trainer.new(TRAINER)
trainer_name = trainer.tr_name

# 敵のHPを準備
enemy_hp = "▓▓▓▓▓▓▓▓▓▓"
allies_hp = "▓▓▓▓▓▓▓▓▓▓"

#############################
# ポケモンのエンカウント
#############################
# 敵ポケモンが現れる
puts "あっ！野生の #{this_enemy_name} があらわれた！"
puts "【 #{this_enemy_name} Lv.5 / HP #{enemy_hp} 】"
puts ""
# sleep 1

# こちらのポケモンを繰り出す
puts "#{trainer_name}「いけっ！ #{this_allies_name}！」"
puts "【 #{this_allies_name} Lv.5 / HP #{allies_hp} 】"
puts ""

#############################
# ポケモンバトル
#############################
until enemy_hp.empty? do
  # わざの表示
  allies.display(allies_command)
  puts ""
  # sleep 1

  # わざの選択
  print "#{this_allies_name} はどうする？ > "
  command = trainer.choice_command(allies_command)

  # トレーナーの指示出し
  puts "#{trainer_name}「#{this_allies_name}、 #{command.waza}！"

  # 相手ポケモンにダメージ
  puts "#{this_enemy_name} に #{command.damage} のダメージ！"
  puts ""
  enemy_hp = enemy_hp.chomp(command.chomp)

  # 相手ポケモンのHP表示
  if enemy_hp.empty?
    puts "【 #{this_enemy_name} Lv.5 / HP ひんし 】"
  else
    puts "【 #{this_enemy_name} Lv.5 / HP #{enemy_hp} 】"
  end
end

# 倒したとき
"#{this_enemy_name} は たおれた！"
puts "#{this_allies_name} は けいけんちを 5 かくとくした！"
