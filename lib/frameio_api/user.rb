module FrameioApi
  class User < OpenStruct
    def self.current(client:)
      client.get_resource('me', object_class: self)
    end
  end
end
