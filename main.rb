require "pry"
require "csv"
require_relative "lib/pokemon"
require_relative "lib/command"
require_relative "lib/trainer"

TRAINER = "たけぴょ"


#############################
# ポケモン名, コマンドCSVマップ取得
#############################
pokemons = Pokemon.import(path: "./csv/pokemon.csv")


#############################
# 味方ポケモン情報
#############################
# ポケモン名, コマンドCSVをセットする
allies = pokemons[3]
this_allies_name = allies.name
this_allies_command = "./csv/#{allies.command_csv}"

# コマンドCSVを読み込む
allies_command = Command.import(path: this_allies_command)

# トレーナー名をセットする
trainer = Trainer.new(TRAINER)
trainer_name = trainer.tr_name

# HPをセットする
allies_hp = "▓▓▓▓▓▓▓▓▓▓"



#############################
# ポケモンバトル開始
#############################

#----------------------------
# 連続バトルのループ
#----------------------------

# バトルカウンタの初期化
battle_cnt = 0
wanna_battle_cnt = 0

# 経験値の初期化
exp_point = 0

puts "何回対戦しますか？"
loop{
  wanna_battle_cnt = gets.to_i
  if wanna_battle_cnt != 0 then
    wanna_battle_cnt
    break
  end
  puts "バトル回数を選択してください。"
}
puts ""

puts "#{wanna_battle_cnt}回の連続バトルを開始します！"
puts ""
puts ""
puts ""
sleep 1

until battle_cnt == wanna_battle_cnt do


#----------------------------
# 相手ポケモンのセット
#----------------------------

# ランダム整数をセットする
randum_num = rand(max = 3)

# ポケモンをランダムに選択する
enemy = pokemons[randum_num]

# ポケモン名, コマンドCSVをセットする
this_enemy_name = enemy.name
this_enemy_command = "./csv/#{enemy.command_csv}"
this_enemy_exp_point = enemy.exp_point.to_i

# コマンドCSVを読み込む
enemy_command = Command.import(path: this_enemy_command)

# HPをセットする
enemy_hp = "▓▓▓▓▓▓▓▓▓▓"

# 相手ポケモンの出現
puts "あっ！野生の #{this_enemy_name} があらわれた！"
puts ""
puts "*" * 30
puts "■ #{this_enemy_name}"
puts "Lv.5 | HP #{enemy_hp}"
puts "*" * 30
puts ""
puts ""
sleep 1

#----------------------------
# 味方ポケモンのセット
#----------------------------

if battle_cnt == 0
  allies_level = 5
  # こちらのポケモンを繰り出す
  puts "#{trainer_name}「いけっ！ #{this_allies_name}！」"
  # puts "*" * 30
  # puts "■ #{this_allies_name}"
  # puts "Lv.5 | HP #{allies_hp}"
  # puts "*" * 30
  # puts ""
  # puts ""
  # sleep 1
end


#----------------------------
# 1バトル →→→→→
#----------------------------
  # どちらかが倒れるまでループ
  until enemy_hp.empty? do

  # [自分のターン]
    # HPの表示
    puts "★" * battle_cnt
    puts "*" * 30
    puts "■ #{this_allies_name}"
    puts "Lv.#{allies_level} | HP #{allies_hp}"
    puts "|" * exp_point
    puts "*" * 30
    puts ""
    puts ""

    # わざの表示
    puts "<#{this_allies_name} の わざ>"
    allies.display(allies_command)
    puts ""

    # わざの選択
    print "#{this_allies_name} はどうする？ > "
    decide_a_command = trainer.choice_command(allies_command)
    puts ""
    sleep 1

    # わざを繰り出す
    puts "#{trainer_name}「#{this_allies_name}、 #{decide_a_command.waza}！」"
    sleep 1

    puts "#{this_enemy_name} に #{decide_a_command.damage} のダメージ！"

    # オーバーキルになる場合の調整
    if enemy_hp.length < decide_a_command.chomp.length
      enemy_hp = enemy_hp.chomp(enemy_hp)
    else
      enemy_hp = enemy_hp.chomp(decide_a_command.chomp)
    end
    puts ""
    sleep 1

    # 相手ポケモンのHP表示
    if enemy_hp.empty?
      puts "*" * 30
      puts "■ #{this_enemy_name}"
      puts "Lv.#{allies_level} | HP ひんし"
      puts "*" * 30
      puts ""
      puts ""
      # 相手ポケモンのHPが0の時、バトル終了
      break
    else
      puts "*" * 30
      puts "■ #{this_enemy_name}"
      puts "Lv.5 | HP #{enemy_hp}"
      puts "*" * 30
      puts ""
      puts ""
    end

  # [相手のターン]
    # わざの選択(ランダム)
    decide_e_command = enemy_command.sample

    # わざを繰り出す
    puts "野生の #{this_enemy_name} の、 #{decide_e_command.waza}！"
    puts ""
    sleep 1
    puts "#{this_allies_name} に #{decide_e_command.damage} のダメージ！"

    # オーバーキルになる場合の調整
    if allies_hp.length < decide_e_command.chomp.length
      allies_hp = allies_hp.chomp(allies_hp)
    else
      allies_hp = allies_hp.chomp(decide_e_command.chomp)
    end
    puts ""
    sleep 1

    # 味方ポケモンのHP表示
    if allies_hp.empty?
      puts "★" * battle_cnt
      puts "*" * 30
      puts "#{this_allies_name}"
      puts "Lv.5 | HP ひんし"
      puts "*" * 30
      puts ""
      # 味方ポケモンのHPが0の時、バトル終了
      break
    else
      puts "★" * battle_cnt
      puts "*" * 30
      puts "#{this_allies_name}"
      puts "Lv.5 | HP #{allies_hp}"
      puts "*" * 30
      puts ""
    end
  end
#----------------------------
# →→→→→ 1バトル
#----------------------------


  # バトル終了時
  if allies_hp.empty?
    puts "#{this_allies_name} は たおれた！"
    puts "#{trainer_name} は めのまえ が まっしろになった。"
    break
  elsif enemy_hp.empty?
    puts "#{this_enemy_name} は たおれた！"

    # 経験値ロジック
    puts "#{this_allies_name} は けいけんちを #{this_enemy_exp_point} かくとくした！"
    exp_point += this_enemy_exp_point
    if exp_point >= 15
      allies_level += 1
      puts "#{this_allies_name} は レベルが #{allies_level} にあがった！"
      puts "ハイドロポンプ をおぼえた！"
    # カウンタの初期化(毎度メッセージが出ることを抑える)
      exp_point = 0
    end
    battle_cnt += 1
    puts "#{battle_cnt}勝！"
    puts "★を#{battle_cnt}つ かくとくした！"
    puts ""
    puts ""
    puts ""
    sleep 1
  end
end

if battle_cnt == wanna_battle_cnt
  puts "#{trainer_name} は 全てのバトルに勝利した！すごい！"
elsif
  puts "#{trainer_name} は #{battle_cnt + 1}戦目で はいぼく してしまった。"
end

