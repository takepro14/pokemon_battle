class Battle

attr_accessor :battle_cnt, :wanna_battle_cnt

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
  def appear_enemy(pokemon_name, pokemon_hp)
    puts "あっ！野生の #{pokemon_name} があらわれた！"
    puts ""
    puts "*" * 30
    puts "■ #{pokemon_name}"
    puts "Lv.5 | HP #{pokemon_hp}"
    puts "*" * 30
    puts ""
    puts ""
    sleep 0.1
  end

  # 味方ポケモンを召喚
  def put_ally(pokemon_name, trainer_name)
    puts "#{trainer_name}「いけっ！ #{pokemon_name}！」"
  end

  def calc_damage(pokemon_name, command, pokemon_hp)
    puts "#{pokemon_name} に #{command.damage} のダメージ！"
    # binding.pry
    # 現在のHPよりもわざで与えるダメージの方が多い時(オーバーキルになる場合)
    if pokemon_hp.length < command.chomp.length
      pokemon_hp = pokemon_hp.chomp(pokemon_hp)
    else
      pokemon_hp = pokemon_hp.chomp(command.chomp)
    end
  end

  def battle_end(ally, enemy, trainer_name)
    # binding.pry
    # バトル終了時
    if ally.hp.empty?
      puts "#{ally.name} は たおれた！"
      puts "#{trainer_name} は めのまえ が まっしろになった。"
    elsif enemy.hp.empty?
      puts "#{enemy.name} は たおれた！"
      # 経験値ロジック
      puts "#{ally.name} は けいけんちを #{enemy.exp_point} かくとくした！"
      ally.exp_point += enemy.exp_point

      # if ally.exp_point >= 15
      #   ally.level += 1
      #   puts "#{ally.name} は レベルが #{ally.level} にあがった！"
      #   puts "ハイドロポンプ をおぼえた！"
      # # カウンタの初期化(毎度メッセージが出ることを抑える)
      #   ally.exp_point = 0
      # end
      @battle_cnt += 1
      # binding.pry
      puts "#{@battle_cnt}勝！"
      puts "★を#{@battle_cnt}つ かくとくした！"
      puts ""
      puts ""
      puts ""
      sleep 0.1
      @battle_cnt
    end
  end

  def battle_end_all(trainer)
    if @battle_cnt == @wanna_battle_cnt
      puts "#{trainer.name} は 全てのバトルに勝利した！すごい！"
    elsif
      puts "#{trainer.name} は #{@battle_cnt + 1}戦目で はいぼく してしまった。"
    end
  end
end