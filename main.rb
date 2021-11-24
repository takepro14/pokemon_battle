require "pry"
require "csv"
require_relative "./lib/pokemon"
require_relative "./lib/command"
require_relative "./lib/trainer"

# binding.pry

#############################
# 変数, インスタンス生成
#############################
### 敵ポケモンがランダムに選択される
# pokemon.csv: name, command.csv



# ポケモンを準備
ENEMY = "ヒトカゲ"
ALLIES = "ゼニガメ"
TRAINER = "たけぴよ"


# pokemon.csvからポケモンの名前とコマンドCSVのマップを取得
pokemons = Pokemon.import(path: "./csv/pokemon.csv")

# 相手ポケモンをランダムに選択
randum_num = rand(max = 3)
enemy = pokemons[randum_num]
this_enemy_name = enemy.name
this_enemy_command = "./csv/#{enemy.command_csv}"


# 味方ポケモンは固定
allies = pokemons[3]
this_allies_name = allies.name
this_allies_command = "./csv/#{allies.command_csv}"


# ポケモンのわざを準備
allies_command = Command.import(path: this_allies_command)
enemy_command = Command.import(path: this_enemy_command)

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
puts "*" * 30
puts "■ #{this_enemy_name}"
puts "Lv.5 | HP #{enemy_hp}"
puts "*" * 30
puts ""
puts ""
sleep 1

# こちらのポケモンを繰り出す
puts "#{trainer_name}「いけっ！ #{this_allies_name}！」"
puts "*" * 30
puts "■ #{this_allies_name}"
puts "Lv.5 | HP #{allies_hp}"
puts "*" * 30
puts ""
puts ""
sleep 1

# binding.pry

#############################
# ポケモンバトル
#############################
# 連続バトル
battle_cnt = 0
until battle_cnt == 3 do
  if battle_cnt != 0
    # 敵ポケモンが現れる
    enemy_hp = "▓▓▓▓▓▓▓▓▓▓"
    puts "つづけて野生の #{this_enemy_name} があらわれた！"
    puts "*" * 30
    puts "■ #{this_enemy_name}"
    puts "Lv.5 | HP #{enemy_hp}"
    puts "*" * 30
    puts ""
    puts ""
    sleep 1
  end
  # どちらかが倒れるまでループ
  until enemy_hp.empty? do
    # わざの表示
    puts "<#{this_allies_name} の わざ>"
    allies.display(allies_command)
    puts ""

    # わざの選択
    print "#{this_allies_name} はどうする？ > "
    decide_a_command = trainer.choice_command(allies_command)
    puts ""
    sleep 1

    ### 味方のターン
    # トレーナーの指示出し
    puts "#{trainer_name}「#{this_allies_name}、 #{decide_a_command.waza}！」"
    sleep 1

    # 相手ポケモンにダメージ
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
      puts "Lv.5 | HP ひんし"
      puts "*" * 30
      puts ""
      puts ""
      break
    else
      puts "*" * 30
      puts "■ #{this_enemy_name}"
      puts "Lv.5 | HP #{enemy_hp}"
      puts "*" * 30
      puts ""
      puts ""
    end

    ### 相手のターン
    # わざをランダムで選択
    decide_e_command = enemy_command.sample

    # わざを繰り出す
    puts "野生の #{this_enemy_name} の、 #{decide_e_command.waza}！"
    puts ""
    sleep 1

    # 味方ポケモンにダメージ
    puts "#{this_allies_name} に #{decide_e_command.damage} のダメージ！"
      # オーバーキルになる場合の調整
      # binding.pry
      if allies_hp.length < decide_e_command.chomp.length
        allies_hp = allies_hp.chomp(allies_hp)
      else
        allies_hp = allies_hp.chomp(decide_e_command.chomp)
      end
    puts ""
    sleep 1
    # 味方ポケモンが倒れたらbreakし、目の前が真っ白
    if allies_hp.empty?
      puts "*" * 30
      puts "#{this_allies_name}"
      puts "Lv.5 | HP ひんし"
      puts "*" * 30
      puts ""
      break
    else
      puts "*" * 30
      puts "#{this_allies_name}"
      puts "Lv.5 | HP #{allies_hp}"
      puts "*" * 30
      puts ""
    end
  end

  # バトル終了時
  if allies_hp.empty?
    puts "#{this_allies_name} は たおれた！"
    puts "#{trainer_name} は めのまえ が まっしろになった。"
    break
  elsif enemy_hp.empty?
    puts "#{this_enemy_name} は たおれた！"
    puts "#{this_allies_name} は けいけんちを 5 かくとくした！"
    battle_cnt += 1
  end
end

# if battle_cnt == 3
  # "#{trainer_name} は 全てのバトルに勝利した！すごい！"
# end
