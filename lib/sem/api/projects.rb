module Sem
  module API
    class Projects < Base
      extend Traits::AssociatedWithOrg
      extend Traits::AssociatedWithTeam

      def self.list
        org_names = Orgs.list.map { |org| org[:username] }

        org_names.map { |name| list_for_org(name) }.flatten
      end

      def self.info(org_name, project_name)
        list_for_org(org_name).find { |project| project[:name] == project_name }
      end

      def self.api
        client.projects
      end

      def self.to_hash(project, _args = {})
        {
          :id => project.id,
          :name => project.name,
          :created_at => project.created_at,
          :updated_at => project.updated_at
        }
      end
    end
  end
end
