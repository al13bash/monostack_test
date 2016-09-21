module Oauth
  class Vk < Oauth::Base
    ACCESS_TOKEN_URL = 'https://oauth.vk.com/access_token'
    DATA_URL = 'https://api.vk.com/method/users.get'

    def get_data
      response = @client.get(DATA_URL, access_token: @access_token, fields: 'first_name, last_name, email, gender, about, link, website, picture')
      @data = JSON.parse(response.body).with_indifferent_access
      @data['image_url'] = @data['picture']['data']['url'] if @data['picture'].present?
      @uid = @data[:id] ||= @data[:sub]
      @data
    end

    def formatted_user_data
      {
        vk_profile:       @data['link'],
        first_name:       @data['first_name'],
        last_name:        @data['last_name'],
        image_url:        @data['image_url'],
        provider:        'vk',
        gender:           @data['gender'],
        token:            @access_token,
        email:            @access_token_response['email'],
        uid:              @access_token_response['user_id']
      }
    end
  end
end
