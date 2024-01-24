ActiveRecord::Base.extend(Module.new do
  def act_as_frameio_user(opts = {})
    FrameioApi.access_token = opts[:access_token]
    FrameioApi.refresh_token = opts[:refresh_token]
    FrameioApi.expires_at = opts[:expires_at]
    include FrameioApi
  end
end)
