module FrameIo
  class Asset < OpenStruct
    def self.children(asset:, client:)
      client.get_resource("assets/#{asset.id}/children", object_class: self)
    end

    def self.find(id:, client:)
      client.get_resource("assets/#{id}", object_class: self)
    end

    def account(cache: true)
      @account = nil unless cache

      @account ||= Account.find(id: account_id, client:)
    end

    def children(cache: true)
      @children = nil unless cache

      @children ||= Asset.children(asset: self, client:)
    end
  end
end
