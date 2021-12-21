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
ally_name = ally.name
ally_commands = ally.set_command("./csv/#{ally.command_csv}")
ally_exp_point = ally.exp_point.to_i
ally_level = ally.level
ally_hp = "▓" * ally.hp.to_i
# ally_speed = ally.speed.to_i

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
  enemy =  enemys[rand(max = enemys.length - 1)]

  # パラメータのセット
  enemy_name = enemy.name
  enemy_command = enemy.set_command("./csv/#{enemy.command_csv}")
  enemy_exp_point = enemy.exp_point.to_i
  enemy_level = enemy.level
  enemy_hp = "▓" * enemy.hp.to_i
  # enemy_speed = enemy.speed.to_i

  # 相手ポケモンの出現
  battle.appear_enemy(enemy_name, enemy_hp)

  # 味方ポケモンを繰り出す
  battle.put_ally(ally_name, trainer_name)


#----------------------------
# ポケモンバトル: 1バトル
#----------------------------
### ループ2: どちらかが倒れるまでループ
  until enemy_hp.empty? do

  # 自分のターン
    # [pokemon] ポケモン：ステータスの表示
    ally.display_status(ally_name, ally_level, ally_hp)

    # [pokemon] ポケモン：わざの表示
    ally.display_command(ally_name, ally_commands)

    # [trainer] トレーナー：わざの選択
    ally_command = trainer.choice_command(ally_name, ally_commands, trainer_name)

    # [battle] ダメージ計算
    enemy_hp = battle.calc_damage(enemy_name, ally_command, enemy_hp)
    # puts ""
    # sleep 0.1

    # 相手ポケモンのHP表示
    enemy.display_status(enemy_name, enemy_level, enemy_hp)

  # 相手のターン
    # わざの選択(ランダム)
    enemy_command = enemy_commands.sample

    # わざを繰り出す
    puts "野生の #{enemy_name} の、 #{decide_e_command.waza}！"
    puts ""
    sleep 0.1
    puts "#{ally_name} に #{decide_e_command.damage} のダメージ！"

    # 味方ポケモンのHP表示
    ally.display_status(ally, ally_hp)
  end

# 1バトル終了時のメッセージ
battle.display_reward()

end

# 全バトル終了時のメッセージ
battle.battle_end(trainer)