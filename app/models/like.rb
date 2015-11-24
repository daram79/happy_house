# coding : utf-8
class Like < ActiveRecord::Base
  belongs_to  :feed
  belongs_to  :user
  has_many :alram, :as => :alram
  
  after_save :create_alram
  after_destroy :delete_alram
  
  def create_alram
    if self.user_id != self.feed.user_id
      self.alram.create(user_id: self.feed.user_id, send_user_id: self.user_id, push_msg: self.user.user_cover.name + "님이 회원님의 사진을 좋아합니다.")
    end
  end
#   self.user.user_cover.name
  
  def delete_alram
    self.alram.destroy_all
  end
end
