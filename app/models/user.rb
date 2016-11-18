class User < ApplicationRecord
  class << self
    def from_omniauth(auth_hash)
      puts auth_hash
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.first_name = auth_hash['info']['first_name']
      user.last_name = auth_hash['info']['last_name']
      user.image_url = auth_hash['info']['image']
      user.gender = auth_hash['extra']['raw_info']['gender']
      user.age_range = auth_hash['extra']['raw_info']['age_range']['min'].to_s+"+"
      user.url = auth_hash['info']['urls'][user.provider.capitalize]
      user.save!
      user
    end
  end
end
