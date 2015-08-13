class Alram < ActiveRecord::Base
  belongs_to :user
  belongs_to :send_user, :foreign_key => "send_user_id", :class_name => "User"
  
  belongs_to :alram, :polymorphic => true
  
  after_create :after_create_alram
  
  def after_create_alram
    Thread.new do
      gcm = GCM.new("AIzaSyCTngq3qlQObAe4-uaWapN3qAfex-Ej75s")
      registration_id = User.where(id: self.user_id).pluck(:registration_id)
      response = gcm.send(registration_id)
      self.update(send_flg: true)
    end
  end
  
end
