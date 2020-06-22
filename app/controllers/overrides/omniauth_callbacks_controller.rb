module Overrides
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
    def assign_provider_attrs(user, auth_hash)
        user.assign_attributes({
          first_name:     auth_hash['info']['first_name'],
          last_name:     auth_hash['info']['last_name'],
          picture_url:    auth_hash['info']['image'],
          email:    auth_hash['info']['email']
        })
      end
  end
end
