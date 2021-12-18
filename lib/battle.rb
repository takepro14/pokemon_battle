class Battle

attr_reader :battle_cnt, :wanna_battle_cnt

  def initialize
    # バトルカウンタの初期化
    @battle_cnt = 0
    @wanna_battle_cnt = 0
    @exp_point = 0

    puts "何回対戦しますか？"
    loop{
      @wanna_battle_cnt = gets.to_i
      if @wanna_battle_cnt != 0 then
        @wanna_battle_cnt
        break
      end
      puts "バトル回数を選択してください。"
    }
    puts ""

    puts "#{@wanna_battle_cnt}回の連続バトルを開始します！"
    puts ""
    puts ""
    puts ""
    sleep 0.1
  end

  # 敵ポケモンの出現
  def appear_enemy(enemy)
    puts "あっ！野生の #{enemy.name} があらわれた！"
    puts ""
    puts "*" * 30
    puts "■ #{enemy.name}"
    puts "Lv.5 | HP #{"▓" * enemy.hp.to_i}"
    puts "*" * 30
    puts ""
    puts ""
    sleep 0.1
  end

  # 味方ポケモンを召喚
  def appear_allies(allies_first, trainer)
    if @battle_cnt == 0
      allies_level = 5
      # こちらのポケモンを繰り出す
      puts "#{trainer.tr_name}「いけっ！ #{allies_first.name}！」"
    end
  end
end