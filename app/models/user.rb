class User < ApplicationRecord

  # Database associations
  has_many :owned_property, :class_name => 'Property', :foreign_key => "uid"
  has_one :rented_property, :class_name => 'Property', :foreign_key => "uid"

  # Mailboxer keyword for giving user models rights to send messages
  acts_as_messageable

  # Method to create user from OAuth token passed from external social network
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

  def mailboxer_email(object)
  end
end
