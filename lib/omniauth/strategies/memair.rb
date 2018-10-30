require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Memair < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://memair.com',
        :authorize_url => 'https://memair.com/oauth/authorize',
        :token_url => 'https://memair.com/oauth/token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'id' => raw_info['id'],
          'email' => raw_info['email'],
          'timezone' => raw_info['timezone'],
        }
      end

      def raw_info
        @raw_info ||= Memair.new(access_token.token).query('query get_user_details{UserDetails{id email timezone}}')['data']['UserDetails']
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'memair', 'Memair'