#coding:utf-8
class VisitorBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :send_user, :foreign_key => "send_user_id", :class_name => "User"
  has_many :alram, :as => :alram
  
  after_save :create_alram
  after_destroy :delete_alram
  
  def create_alram
    if self.user_id != self.send_user_id
      self.alram.create(user_id: self.user_id, send_user_id: self.send_user_id, push_msg: self.send_user.user_cover.name+"님이 방명록에 글을 남겼습니다.")
      self.user.update(visiter_book_read_flg: false)
    end
  end
  
  def delete_alram
    self.alram.destroy_all
  end
  
end
