# coding : utf-8
class User < ActiveRecord::Base
  has_one :user_cover, :dependent => :destroy
  has_many :feeds
  has_many :user_visit_counts
  has_many :likes
  has_many :alrams
  has_many :send_user_alrams, :foreign_key => "send_user_id", :class_name => "Alram"
  has_many :comments
  has_many :alram, :as => :alram
  has_many :registrations
  has_many :visitor_books
  has_many :user_likes
  
  after_create :create_alram
  after_create :create_visitor_book
  
  def create_alram
    # user_ids = User.where(alram_on: true).pluck(:id)
    # user_ids.delete(self.id)
    user_ids = [1, 2]
    user_ids.each do |user_id|
      self.alram.create(user_id: user_id, send_user_id: self.id, push_msg: "새로운 회원이 가입했습니다.")
    end
  end
  
  def create_visitor_book
    lottery = Lottery.last
    visitor_book_content = FirstVisitorBookContent.last
    self.visitor_books.create(user_id: self.id, send_user_id: 1, content: visitor_book_content.content) if FirstVisitorBookContent.send_flg
  end
  
end
