class UserVisitCount < ActiveRecord::Base
  belongs_to :user
  
  after_save :update_user_visit_count
  
  def self.chk_visit_data(user_id, visit_user_id)
    search_start_time = (DateTime.now).utc
    search_start_time = search_start_time.change(hour: 0)
    
    visit_data = UserVisitCount.where(user_id: user_id, visit_user_id: visit_user_id).where("created_at > ?", search_start_time)
    ret = false;
    ret = true if visit_data.blank?
    
    return ret;
  end
  
  def update_user_visit_count
    user = User.find(self.user_id)
    last_count_day = user.last_count_day
    today = (DateTime.now).utc.day.to_s
    if !last_count_day || !today.eql?(last_count_day) #최초 방문자
      today_visit_count = 1;
    else today.eql?(last_count_day)
      today_visit_count = user.today_visit_count + 1;  
    end
    user.update(today_visit_count: today_visit_count, total_visit_count: user.total_visit_count + 1, last_count_day: today)
  end
end
