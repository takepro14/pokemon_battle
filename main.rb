require "pry"
require "csv"
require_relative "lib/pokemon"
require_relative "lib/command"
require_relative "lib/trainer"
require_relative "lib/battle"

TRAINER = "たけぴょ"
# binding.pry


#----------------------------
# ポケモンの生成, コマンドCSVセット
#----------------------------
enemys = Pokemon.import(path: "./csv/enemys.csv")
allies = Pokemon.import(path: "./csv/allies.csv")
# binding.pry


#----------------------------
# 味方ポケモンセット
#----------------------------
allies_first = allies[0]

# パラメータのセット
allies_command = allies_first.set_command("./csv/#{allies_first.command_csv}")
allies_name = allies_first.name
allies_speed = allies_first.speed.to_i
allies_hp = "▓" * allies_first.hp.to_i

# トレーナー名をセットする
trainer = Trainer.new(TRAINER)
trainer_name = trainer.tr_name



#----------------------------
# ポケモンバトル開始
#----------------------------

# 連続バトルのループ

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
sleep 0.1

until battle_cnt == wanna_battle_cnt do


#----------------------------
# 相手ポケモンのセット
#----------------------------
# ポケモンをランダムに選択する
enemy =  enemys[rand(max = enemys.length - 1)]

# パラメータのセット
enemy_command = enemy.set_command("./csv/#{enemy.command_csv}")
enemy_name = enemy.name
enemy_exp_point = enemy.exp_point.to_i
enemy_speed = enemy.speed.to_i
enemy_hp = "▓" * enemy.hp.to_i

# 相手ポケモンの出現
battle = Battle.new
battle.encount(enemy)

#----------------------------
# 味方ポケモンのセット
#----------------------------

if battle_cnt == 0
  allies_level = 5
  # こちらのポケモンを繰り出す
  puts "#{trainer_name}「いけっ！ #{allies_name}！」"
  # puts "*" * 30
  # puts "■ #{allies_name}"
  # puts "Lv.5 | HP #{allies_hp}"
  # puts "*" * 30
  # puts ""
  # puts ""
  # sleep 0.1
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
    puts "■ #{allies_name}"
    puts "Lv.#{allies_level} | HP #{allies_hp}"
    puts "|" * exp_point
    puts "*" * 30
    puts ""
    puts ""

    # わざの表示
    puts "<#{allies_name} の わざ>"
    allies_first.display(allies_command)
    puts ""

    # わざの選択
    print "#{allies_name} はどうする？ > "
    decide_a_command = trainer.choice_command(allies_command)
    puts ""
    sleep 0.1

    # わざを繰り出す
    puts "#{trainer_name}「#{allies_name}、 #{decide_a_command.waza}！」"
    sleep 0.1

    puts "#{enemy_name} に #{decide_a_command.damage} のダメージ！"

    # オーバーキルになる場合の調整
    if enemy_hp.length < decide_a_command.chomp.length
      enemy_hp = enemy_hp.chomp(enemy_hp)
    else
      enemy_hp = enemy_hp.chomp(decide_a_command.chomp)
    end
    puts ""
    sleep 0.1

    # 相手ポケモンのHP表示
    if enemy_hp.empty?
      puts "*" * 30
      puts "■ #{enemy_name}"
      puts "Lv.#{allies_level} | HP ひんし"
      puts "*" * 30
      puts ""
      puts ""
      # 相手ポケモンのHPが0の時、バトル終了
      break
    else
      puts "*" * 30
      puts "■ #{enemy_name}"
      puts "Lv.5 | HP #{enemy_hp}"
      puts "*" * 30
      puts ""
      puts ""
    end

  # [相手のターン]
    # わざの選択(ランダム)
    decide_e_command = enemy_command.sample

    # わざを繰り出す
    puts "野生の #{enemy_name} の、 #{decide_e_command.waza}！"
    puts ""
    sleep 0.1
    puts "#{allies_name} に #{decide_e_command.damage} のダメージ！"

    # オーバーキルになる場合の調整
    if allies_hp.length < decide_e_command.chomp.length
      allies_hp = allies_hp.chomp(allies_hp)
    else
      allies_hp = allies_hp.chomp(decide_e_command.chomp)
    end
    puts ""
    sleep 0.1

    # 味方ポケモンのHP表示
    if allies_hp.empty?
      puts "★" * battle_cnt
      puts "*" * 30
      puts "#{allies_name}"
      puts "Lv.5 | HP ひんし"
      puts "*" * 30
      puts ""
      # 味方ポケモンのHPが0の時、バトル終了
      break
    else
      puts "★" * battle_cnt
      puts "*" * 30
      puts "#{allies_name}"
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
    puts "#{allies_name} は たおれた！"
    puts "#{trainer_name} は めのまえ が まっしろになった。"
    break
  elsif enemy_hp.empty?
    puts "#{enemy_name} は たおれた！"

    # 経験値ロジック
    puts "#{allies_name} は けいけんちを #{enemy_exp_point} かくとくした！"
    exp_point += enemy_exp_point
    if exp_point >= 15
      allies_level += 1
      puts "#{allies_name} は レベルが #{allies_level} にあがった！"
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
    sleep 0.1
  end
end

  if battle_cnt == wanna_battle_cnt
    puts "#{trainer_name} は 全てのバトルに勝利した！すごい！"
  elsif
    puts "#{trainer_name} は #{battle_cnt + 1}戦目で はいぼく してしまった。"
  end
