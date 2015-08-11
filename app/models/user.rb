class User < ActiveRecord::Base
  has_one :user_cover, :dependent => :destroy
  has_many :feeds
  has_many :user_visit_counts
  has_many :likes
  has_many :alrams
  has_many :send_user_alrams, :foreign_key => "send_user_id", :class_name => "Alram"
  has_many :comments
  
end