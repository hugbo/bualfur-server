json.user do
  json.facebook_id @user.uid
  json.first_name @user.first_name
  json.last_name @user.last_name
  json.gender @user.gender
  json.age_range @user.age_range
  json.image_url @user.image_url
  json.facebook_url @user.url
  json.phone_number @user.phone_number
  json.personal_info @user.personal_info
  json.email @user.email
end
