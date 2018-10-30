require 'omniauth-oauth2'
require 'httparty'

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

      uid { raw_info['data']['UserDetails']['id'].to_s }

      info do
        {
          'id' => raw_info['data']['UserDetails']['id'],
          'email' => raw_info['data']['UserDetails']['email'],
          'timezone' => raw_info['data']['UserDetails']['timezone'],
        }
      end

      def raw_info
        @raw_info ||= HTTParty.post("https://memair.com/graphql", body: { access_token: access_token.token, query: 'query get_user_details{UserDetails{id email timezone}}' }, timeout: 180)
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'memair', 'Memair'
