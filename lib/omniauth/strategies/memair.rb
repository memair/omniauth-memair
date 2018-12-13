require 'omniauth-oauth2'
require 'httparty'

module OmniAuth
  module Strategies
    class Memair < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'user_details'

      option :client_options, {
        :site => 'https://memair.com',
        :authorize_url => 'https://memair.com/oauth/authorize',
        :token_url => 'https://memair.com/oauth/token'
      }

      option :authorize_options, [:scope, :permissions]

      uid { raw_info['data']['UserDetails']['id'].to_s }

      info do
        {
          'id' => raw_info['data']['UserDetails']['id'],
          'email' => raw_info['data']['UserDetails']['email'],
          'time_zone' => raw_info['data']['UserDetails']['time_zone'],
        }
      end

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          options[:authorize_options].each do |option|
            params[option] = request.params[option.to_s] if request.params[option.to_s]
          end

          params[:redirect_uri] = options[:redirect_uri] unless options[:redirect_uri].nil?

          params[:scope] = params[:scope]&.include?(DEFAULT_SCOPE) ? params[:scope] : (DEFAULT_SCOPE + ' ' + params[:scope].to_s).strip
        end
      end

      def raw_info
        @raw_info ||= HTTParty.post("https://memair.com/graphql", body: { access_token: access_token.token, query: 'query get_user_details{UserDetails{id email time_zone}}' }, timeout: 180)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      rescue ::OAuth::Error => e
        raise e.response.inspect
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'memair', 'Memair'
