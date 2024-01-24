module FrameioApi
  class CustomAction < OpenStruct
    def self.all(team:, client:)
      client.get_resource("teams/#{team.id}/actions", object_class: self)
    end

    def self.find(id:, client:)
      client.get_resource("actions/#{id}", object_class: self)
    end
  end
end
