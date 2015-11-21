#encoding: utf-8
require 'gcm'
require "#{File.dirname(__FILE__)}/../../config/environment.rb"


# registration_id = Alram.where(send_flg: false).group(:user_id).includes(:user).pluck(:registration_id)
registration_ids = []
alrams = Alram.where(send_flg: false).group(:user_id)
alrams.each do |alram|
  regi_ids = alram.user.registrations.pluck(:registration_id)
  registration_ids += regi_ids
end

registration_ids.compact
unless registration_ids.blank?
  gcm = GCM.new("AIzaSyCTngq3qlQObAe4-uaWapN3qAfex-Ej75s")
  response = gcm.send(registration_ids)
  alrams = Alram.where(send_flg: false)
  alrams.update_all(send_flg: true)
end