#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"
require 'gcm'

# registration_id = Alram.where(send_flg: false).group(:user_id).includes(:user).pluck(:registration_id)
registration_ids = []
alrams = Alram.where(send_flg: false).group(:user_id)
alrams.each do |alram|
  regi_ids = alram.user.registrations.pluck(:registration_id)
  registration_ids += regi_ids
end

registration_ids.compact!

unless registration_ids.blank?
  gcm = GCM.new("AIzaSyCTngq3qlQObAe4-uaWapN3qAfex-Ej75s")
  response = gcm.send(registration_ids)
  # alrams = Alram.where(send_flg: false)
  # alrams.update_all(send_flg: true)
  rr = JSON.parse(response[:body])["results"]
  
  delete_id_index = []
  update_id_index = []
  resend_id_index = []
  
  delete_ids = []
  update_ids = []
  resend_ids = []
  
  rr.each_with_index { |r, i|
    if r.key?("error") && r.value?("NotRegistered")
      delete_id_index.push i
    elsif r.key?("error") && r.value?("InvalidRegistration")
      delete_id_index.push i
    elsif r.key?("message_id") && r.key?("registration_id")
      delete_id_index.push i
    elsif r.key?("error") && r.value?("Unavailable")
      resend_id_index.push i
    elsif r.key?("message_id") && r.size == 1
      update_id_index.push i
    end
  }
  delete_id_index.each do |i|
    delete_ids.push registration_ids[i]
  end
  
  update_id_index.each do |i|
    update_ids.push registration_ids[i]
  end
  
  registrations = Registration.where(registration_id: delete_ids)
  registrations.destroy_all
  
  # User.includes(:registrations).where(registrations: { registration_id: update_ids }).pluck(:id)
  user_ids = Registration.where(registration_id: update_ids).pluck(:user_id)
  alrams = Alram.where(user_id: user_ids)
  alrams.update_all(send_flg: true)
  
  resend_id_index.each do |i|
    resend_ids.push registration_ids[i]
  end
  user_ids = Registration.where(registration_id: resend_ids).pluck(:user_id)
  alrams = Alram.where(user_id: user_ids)
  alrams.update_all(send_flg: false)
  
end