require_relative "pokemon"

class Trainer
  attr_reader :tr_name

  def initialize(tr_name)
    @tr_name = tr_name
  end

  def choice_command(whose_command)
    num = gets.to_i
    whose_command[num - 1]
  end


    # # コマンドの実行
    # puts "#{this_allies_name} の #{choice_command.waza}！"
      # end
end