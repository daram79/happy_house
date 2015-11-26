json.extract! @alram, :alram_type, :send_user_id
if @alram.alram_type == "User"
	json.send_user_name ""
else
	json.send_user_name @alram.send_user.user_cover.name
end
json.push_msg @alram.push_msg
