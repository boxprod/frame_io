module FrameioApi
  class Team < OpenStruct
    def self.all(account:, client:)
      client.get_resource("accounts/#{account.id}/teams?include=user_role", object_class: self)
    end

    def self.find(id:, client:)
      client.get_resource("teams/#{id}", object_class: self)
    end

    def projects(cache: true)
      @projects = nil unless cache

      @projects ||= Project.all(team: self, client:)
    end

    def custom_actions(cache: true)
      @custom_actions = nil unless cache

      @custom_actions ||= CustomAction.all(team: self, client:)
    end
  end
end
