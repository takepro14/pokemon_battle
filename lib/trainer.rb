require_relative "pokemon"

class Trainer
  attr_reader :tr_name

  def initialize(tr_name)
    @tr_name = tr_name
  end

  def choice_command(pokemon, whose_command)
    print "#{pokemon.name} はどうする？ > "
    # 入力を必須にする
    loop{
      num = gets.to_i
      # binding.pry
      if num != 0 then
        # 選択したコマンド>コマンドの数でない かつ unlockedがNではないなら
        unless num > whose_command.size
          unless whose_command[num - 1].unlocked == "N"
            num
            @num = num
            break
          end
        end
      end
      puts "わざ が せんたくされていません。もういちど せんたくしてください。"
    }
    whose_command[@num - 1]
    puts ""
    sleep 0.1
  end


    # # コマンドの実行
    # puts "#{this_allies_name} の #{choice_command.waza}！"
      # end
end