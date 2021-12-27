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

# binding.pry

# 手持ちの先頭ポケモンをセット
ally = allies[0]

# パラメータのセット
ally_name = ally.name
ally_commands = ally.set_command("./csv/#{ally.command_csv}")
ally_exp_point = ally.exp_point
ally_level = ally.level
ally_hp = ally.hp
ally_speed = ally.speed

# トレーナー名をセットする
trainer = Trainer.new(TRAINER)
trainer_name = trainer.name


#----------------------------
# ポケモンバトル: 指定回数ループ
#----------------------------
# バトルインスタンスの生成
battle = Battle.new

### ループ1: 指定バトル回数分ループ
until battle.battle_cnt == battle.wanna_battle_cnt do

  # ポケモンをランダムに選択する
  enemy_org = enemys[rand(max = enemys.length)]
  enemy = enemy_org.clone

  # パラメータのセット
  enemy_name = enemy.name
  enemy_commands = enemy.set_command("./csv/#{enemy.command_csv}")
  enemy_exp_point = enemy.exp_point
  enemy_level = enemy.level
  enemy_hp = enemy.hp
  enemy_speed = enemy.speed

  # 相手ポケモンの出現
  battle.appear_enemy(enemy_name, enemy_hp)
  # binding.pry

  # 味方ポケモンを繰り出す
  if battle.battle_cnt == 0
    battle.put_ally(ally_name, trainer_name)
  end

#----------------------------
# ポケモンバトル: 1バトル
#----------------------------
### ループ2: どちらかが倒れるまでループ
  until enemy_hp.empty? do

    # すばやさの判定
    if ally_speed >= enemy_speed

    # 自分のターン
      # ポケモン：ステータスの表示
      ally.display_status(ally_name, ally_level, ally_hp, ally.exp_point)

      # ポケモン：わざの表示
      ally.display_command(ally_name, ally_commands)

      # トレーナー：わざの選択
      ally_command = trainer.choice_command(ally_name, ally_commands, trainer_name)

      # ダメージ計算し、インスタンスのhpを更新
      enemy.hp = battle.calc_damage(enemy_name, ally_command, enemy_hp)
      enemy_hp = enemy.hp

      # 相手ポケモンのHP表示
      enemy.display_status(enemy_name, enemy_level, enemy_hp, enemy.exp_point)

    # 相手のターン
    if enemy_hp.empty?
      # 1バトル終了時のメッセージ
      battle.battle_cnt = battle.battle_end(ally, enemy, trainer_name, ally_commands)
      # binding.pry
    else
      # わざの選択(ランダム)
      enemy_command = enemy_commands.sample

      # わざを繰り出す
      puts "野生の #{enemy_name} の、 #{enemy_command.waza}！"
      puts ""
      sleep 0.1
      puts "#{ally_name} に #{enemy_command.damage} のダメージ！"
    end


    else

    # 相手のターン
      if enemy_hp.empty?
        # 1バトル終了時のメッセージ
        battle.battle_cnt = battle.battle_end(ally, enemy, trainer_name, ally_commands)
        # binding.pry
      else
        # わざの選択(ランダム)
        enemy_command = enemy_commands.sample

        # わざを繰り出す
        puts "野生の #{enemy_name} の、 #{enemy_command.waza}！"
        puts ""
        sleep 0.1
        puts "#{ally_name} に #{enemy_command.damage} のダメージ！"
      end

    # 自分のターン
      # ポケモン：ステータスの表示
      ally.display_status(ally_name, ally_level, ally_hp, ally.exp_point)

      # ポケモン：わざの表示
      ally.display_command(ally_name, ally_commands)

      # トレーナー：わざの選択
      ally_command = trainer.choice_command(ally_name, ally_commands, trainer_name)

      # ダメージ計算し、インスタンスのhpを更新
      enemy.hp = battle.calc_damage(enemy_name, ally_command, enemy_hp)
      enemy_hp = enemy.hp

      # 相手ポケモンのHP表示
      enemy.display_status(enemy_name, enemy_level, enemy_hp, enemy.exp_point)
    end
  end
end

# 全バトル終了時のメッセージ
battle.battle_end_all(trainer)