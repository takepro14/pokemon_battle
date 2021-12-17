class Battle
  def encount(enemy)
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
end