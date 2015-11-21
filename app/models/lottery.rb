class Lottery < ActiveRecord::Base
  
  def self.create_lottery(tel_no, type, today, user_id, chance)
    lottery = Lottery.create(tel_no: tel_no, lottery_type: type, date: today, user_id: user_id, chance: chance)
    if lottery.id < 101
      win_per = 3 #25
    # elsif lottery.id < 101
      # win_per = 30  #2
    elsif lottery.id < 1001
      win_per = 30  # 30
    elsif lottery.id < 2001
      win_per = 100  # 10
    elsif lottery.id >= 2001
      win_per = 100000
    end
    if (lottery.id % win_per) == 0
      lottery.update(is_win: true)
    end
    return lottery
  end
end
