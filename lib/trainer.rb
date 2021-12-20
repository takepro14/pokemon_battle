require_relative "pokemon"

class Trainer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def choice_command(pokemon, commands, trainer)
    print "#{pokemon.name} はどうする？ > "
    # 入力を必須にする
    loop{
      num = gets.to_i
      # binding.pry
      if num != 0 then
        # 選択したコマンド>コマンドの数でない かつ unlockedがNではないなら
        unless num > commands.size
          unless commands[num - 1].unlocked == "N"
            num
            @num = num
            break
          end
        end
      end
      puts "わざ が せんたくされていません。もういちど せんたくしてください。"
    }
    sleep 0.5
    puts ""
    puts "#{trainer.name}「#{pokemon.name}、 #{commands[@num - 1].waza}！」"
    commands[@num - 1]
  end


    # # コマンドの実行
    # puts "#{this_allies_name} の #{choice_command.waza}！"
      # end
end