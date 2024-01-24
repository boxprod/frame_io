module FrameioApi
  class Client
    attr_reader :user, :api_key

    def initialize(user:)
      @user = user
    end

    def get_resource(resource_path, object_class:)
      check_token
      response = token.get(resource_path)
      result = JSON.parse(
        response.body,
        symbolize_names: true,
        object_class:
      )
      if result.is_a? OpenStruct
        result.client = self
      elsif result.is_a? Array
        result.each { _1.client = self }
      end
      result
    end

    def token
      OAuth2::AccessToken.from_hash(
        oauth.client,
        {
          access_token: user.send(FrameioApi.access_token),
          refresh_token: user.send(FrameioApi.refresh_token),
          expires_at: user.send(FrameioApi.expires_at)
        }
      )
    end

    def oauth
      OmniAuth::Strategies::Frameio.new(
        nil,
        ENV['FRAME_CLIENT_ID'],
        ENV['FRAME_CLIENT_SECRET']
      )
    end

    def accounts(cache: true)
      @accounts = nil unless cache

      @accounts ||= Account.all(client: self)
    end

    def current_user
      User.current(client: self)
    end

    def account(id:)
      Account.find(id:, client: self)
    end

    def team(id:)
      Team.find(id:, client: self)
    end

    def project(id:)
      Project.find(id:, client: self)
    end

    def asset(id:)
      Asset.find(id:, client: self)
    end

    def custom_action(id:)
      CustomAction.find(id:, client: self)
    end

    private

    def check_token
      return unless token.expired?

      new_token = token.refresh!

      raise TokenError, 'something went wrong with token refresh' unless new_token.present?

      user.update(
        frameio_token: new_token.token,
        frameio_token_expires_at: Time.at(new_token.expires_at),
        frameio_refresh_token: new_token.refresh_token
      )
    end
  end
end
