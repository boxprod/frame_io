ActiveRecord::Base.extend(Module.new do
  def act_as_frameio_user(opts = {})
    FrameIo.access_token = opts[:access_token]
    FrameIo.refresh_token = opts[:refresh_token]
    FrameIo.expires_at = opts[:expires_at]
    include FrameIo
  end
end)
