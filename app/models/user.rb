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
  
  after_create :create_alram
  
  def create_alram
    # user_ids = User.where(alram_on: true).pluck(:id)
    # user_ids.delete(self.id)
    user_ids = [1, 2]
    user_ids.each do |user_id|
      self.alram.create(user_id: user_id, send_user_id: self.id)
    end
  end
  
  
end
