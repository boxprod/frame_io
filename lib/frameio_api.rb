require "frameio_api/version"
require "frameio_api/railtie"
require 'frameio_api/account'
require 'frameio_api/active_record_extension'
require 'frameio_api/asset'
require 'frameio_api/client'
require 'frameio_api/collaborator'
require 'frameio_api/custom_action'
require 'frameio_api/project'
require 'frameio_api/team'
require 'frameio_api/user'
require 'omniauth-frameio'

module FrameioApi
  TokenError = Class.new(StandardError)

  class << self
    attr_writer :access_token, :refresh_token, :expires_at
  end

  def self.included(base)
    return if [
      access_token,
      refresh_token,
      expires_at
    ].all? { base.attribute_method? _1 }

    raise TokenError, "#{base} must implement ##{access_token}, ##{refresh_token}, ##{expires_at} or define otherwise at include."
  end

  def frame_io
    Client.new(user: self)
  end

  def self.access_token
    @access_token || :access_token
  end

  def self.refresh_token
    @refresh_token || :refresh_token
  end

  def self.expires_at
    @expires_at || :expires_at
  end
end

