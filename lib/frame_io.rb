require "frame_io/version"
require "frame_io/railtie"
require 'frame_io/account'
require 'frame_io/active_record_extension'
require 'frame_io/asset'
require 'frame_io/client'
require 'frame_io/collaborator'
require 'frame_io/custom_action'
require 'frame_io/project'
require 'frame_io/team'
require 'frame_io/user'
require 'omniauth-frameio'

module FrameIo
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

