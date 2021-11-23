require_relative "pokemon"

class Trainer
  attr_reader :tr_name

  def initialize(tr_name)
    @tr_name = tr_name
  end

  def choice_command(whose_command)
    # 入力を必須にする
    loop{
      num = gets.to_i
      # binding.pry
      if num != 0 then
        @num = num
        break
      end
      puts "わざ が せんたくされていません。もういちど せんたくしてください。"
    }
    whose_command[@num - 1]
  end


    # # コマンドの実行
    # puts "#{this_allies_name} の #{choice_command.waza}！"
      # end
end