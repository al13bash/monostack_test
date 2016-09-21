module Oauth
  class Base
    attr_reader :provider, :data, :access_token, :uid

    def initialize(params)
      @provider = self.class.name.split('::').last.downcase
      prepare_params params
      puts "PARAMS - #{@params}"
      @client = HTTPClient.new
      @access_token = params[:access_token].presence || get_access_token
      puts "ACCESS TOKEN IS - #{@access_token}"
      get_data if @access_token.present?
    end

    def get_access_token
      response = @client.post(self.class::ACCESS_TOKEN_URL, @params)
      puts "ACCESS TOKEN RESPONSE - #{response.body}"
      @access_token_response = JSON.parse(response.body)
      @access_token_response['access_token']
    end

    def prepare_params(params)
      @params = {
        code:          params[:code],
        redirect_uri:  params[:redirectUri],
        client_id:     Rails.application.secrets["#{@provider.upcase}_APP_ID".to_sym],
        client_secret: Rails.application.secrets["#{@provider.upcase}_APP_SECRET".to_sym],
        grant_type:    'authorization_code'
      }
    end

    def authorized?
      @access_token.present?
    end
  end
end
