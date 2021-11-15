require_relative "pokemon"

class Trainer
  attr_reader :tr_name, :choice_command

  def initialize(tr_name)
    @tr_name = tr_name
    @choice_command = []
  end

  def choice_command(whose_command)
    num = gets.to_i
    @choice_command << whose_command[num - 1]
    puts ""
  end


    # # コマンドの実行
    # puts "#{this_allies_name} の #{choice_command.waza}！"
      # end
end