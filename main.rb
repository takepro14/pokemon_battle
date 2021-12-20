require "pry"
require "csv"
require_relative "lib/pokemon"
require_relative "lib/command"
require_relative "lib/trainer"
require_relative "lib/battle"

TRAINER = "たけぴょ"
# binding.pry


#----------------------------
# 各種変数のセット
#----------------------------
# ポケモンの基本情報をCSVからインポート
enemys = Pokemon.import(path: "./csv/enemys.csv")
allies = Pokemon.import(path: "./csv/allies.csv")

# 手持ちの先頭ポケモンをセット
ally = allies[0]

# パラメータのセット
ally_command = ally.set_command("./csv/#{ally.command_csv}")
ally_name = ally.name
ally_speed = ally.speed.to_i
ally_hp = "▓" * ally.hp.to_i

# トレーナー名をセットする
trainer = Trainer.new(TRAINER)
trainer_name = trainer.name


#----------------------------
# ポケモンバトル: 指定回数ループ
#----------------------------
# バトルインスタンスの生成
battle = Battle.new

# 指定したバトル回数になるまでバトルを繰り返す
until battle.battle_cnt == battle.wanna_battle_cnt do

  # ポケモンをランダムに選択する
  enemy =  enemys[rand(max = enemys.length - 1)]

  # パラメータのセット
  enemy_command = enemy.set_command("./csv/#{enemy.command_csv}")
  enemy_name = enemy.name
  enemy_exp_point = enemy.exp_point.to_i
  enemy_speed = enemy.speed.to_i
  enemy_hp = "▓" * enemy.hp.to_i


  # 相手ポケモンの出現
  battle.appear_enemy(enemy)

  # 味方ポケモンの召喚
  battle.put_ally(ally, trainer)


#----------------------------
# ポケモンバトル: 1バトル
#----------------------------
# どちらかが倒れるまでループ
  until enemy_hp.empty? do

  # [自分のターン]
    # [pokemon] ポケモン：ステータスの表示
    ally.display_status(ally, ally_hp)

    # [pokemon] ポケモン：わざの表示
    ally.display_command(ally, ally_command)

    # [trainer] トレーナー：わざの選択
    decide_a_command = trainer.choice_command(ally, ally_command, trainer)

    # [battle] ダメージ計算
    enemy_hp = battle.calc_damage(enemy, decide_a_command, enemy_hp)
    puts ""
    sleep 0.1

    # 相手ポケモンのHP表示
    enemy.display_status(enemy, enemy_hp)

  # [相手のターン]
    # わざの選択(ランダム)
    decide_e_command = enemy_command.sample

    # わざを繰り出す
    puts "野生の #{enemy_name} の、 #{decide_e_command.waza}！"
    puts ""
    sleep 0.1
    puts "#{ally_name} に #{decide_e_command.damage} のダメージ！"

    # オーバーキルになる場合の調整
    # if ally_hp.length < decide_e_command.chomp.length
    #   ally_hp = ally_hp.chomp(ally_hp)
    # else
    #   ally_hp = ally_hp.chomp(decide_e_command.chomp)
    # end
    puts ""
    sleep 0.1

    # 味方ポケモンのHP表示
    ally.display_status(ally)
    # if ally_hp.empty?
    #   puts "★" * battle_cnt
    #   puts "*" * 30
    #   puts "#{ally_name}"
    #   puts "Lv.5 | HP ひんし"
    #   puts "*" * 30
    #   puts ""
    #   # 味方ポケモンのHPが0の時、バトル終了
    #   break
    # else
    #   puts "★" * battle_cnt
    #   puts "*" * 30
    #   puts "#{ally_name}"
    #   puts "Lv.5 | HP #{ally_hp}"
    #   puts "*" * 30
    #   puts ""
    # end
  end

#----------------------------
# →→→→→ 1バトル
#----------------------------

  # バトル終了時
  if ally_hp.empty?
    puts "#{ally_name} は たおれた！"
    puts "#{trainer_name} は めのまえ が まっしろになった。"
    break
  elsif enemy_hp.empty?
    puts "#{enemy_name} は たおれた！"

    # 経験値ロジック
    puts "#{ally_name} は けいけんちを #{enemy.exp_point} かくとくした！"
    ally.exp_point += enemy.exp_point
    if ally.exp_point >= 15
      ally.level += 1
      puts "#{ally.name} は レベルが #{ally.level} にあがった！"
      puts "ハイドロポンプ をおぼえた！"
    # カウンタの初期化(毎度メッセージが出ることを抑える)
      ally.exp_point = 0
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

battle.battle_end(trainer)