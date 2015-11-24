#coding : utf-8
class Comment < ActiveRecord::Base
  belongs_to  :feed
  belongs_to  :user
  has_many :alram, :as => :alram
  
  after_save :create_alram
  after_destroy :delete_alram
  
  def create_alram
    ids = self.feed.comments.group(:user_id).pluck(:user_id) - [self.feed.user_id, self.user_id]
    ids.each do |id|
      self.alram.create(user_id: id, send_user_id: self.user_id, push_msg: "댓글을 단 글에 댓글이 달렸습니다.")
    end
    
    if self.user_id != self.feed.user_id
      self.alram.create(user_id: self.feed.user_id, send_user_id: self.user_id, push_msg: self.user.user_cover.name+"님이 사진에 댓글을 달았습니다.")
    end
  end
  
  def delete_alram
    self.alram.destroy_all
  end
end
