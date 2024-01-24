module FrameIo
  class Collaborator < OpenStruct
    def self.all(project:, client:)
      client.get_resource("projects/#{project.id}/collaborators", object_class: self)
    end
  end
end
