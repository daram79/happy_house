class VisitorBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :send_user, :foreign_key => "send_user_id", :class_name => "User"
  has_many :alram, :as => :alram
  
  after_save :create_alram
  after_destroy :delete_alram
  
  def create_alram
    if self.user_id != self.send_user_id
      self.alram.create(user_id: self.user_id, send_user_id: self.send_user_id)
    end
  end
  
  def delete_alram
    self.alram.destroy_all
  end
  
end
