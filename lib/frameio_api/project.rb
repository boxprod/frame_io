module FrameioApi
  class Project < OpenStruct
    def self.all(team:, client:)
      client.get_resource("teams/#{team.id}/projects", object_class: self)
    end

    def self.find(id:, client:)
      client.get_resource("projects/#{id}", object_class: self)
    end

    def root
      @root ||= Asset.find(id: root_asset.id, client:)
    end

    def account
      root.account
    end

    def assets(cache: true)
      @assets = nil unless cache

      @assets ||= root.children(cache:)
    end

    def collaborators(cache: true)
      @collaborators = nil unless cache

      @collaborators ||= Collaborator.all(project: self, client:)
    end
  end
end
