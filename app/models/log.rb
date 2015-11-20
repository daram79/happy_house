class Log < ActiveRecord::Base
  
  def self.create_log( cookie, f_log, s_log, device, user_id = nil)
    Log.create(uniq_key: cookie, user_id: user_id, first_log_type: f_log, second_log_type: s_log, device: device)
  end
  
end
