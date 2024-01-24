module FrameioApi
  class Account < OpenStruct
    def self.all(client:)
      client.get_resource('accounts', object_class: self)
    end

    def self.find(id:, client:)
      client.get_resource("accounts/#{id}", object_class: self)
    end

    def teams(cache: true)
      @teams = nil unless cache

      @teams ||= Team.all(account: self, client:)
    end
  end
end
