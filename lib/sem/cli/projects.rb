class Sem::CLI::Projects < Dracula

  desc "list", "list projects"
  def list
    projects = Sem::API::Projects.list

    Sem::Views::Projects.list(projects)
  end

  desc "info", "shows detailed information about a project"
  def info(project)
    org_name, project_name = Sem::SRN.parse_project(project)

    project_instance = Sem::API::Projects.info(org_name, project_name).to_h

    Sem::Views::Projects.info(project_instance)
  end

  desc "create", "create a project"
  option :url, :aliases => "-u", :desc => "Git url to the repository"
  def create(project)
    org_name, project_name = Sem::SRN.parse_project(project)
    repo_provider, repo_owner, repo_name = Sem::Helpers::Git.parse_url(options[:url])

    project = Sem::API::Projects.create(org_name,
                                        :name => team_name,
                                        :repo_provider => repo_provider,
                                        :repo_owner => repo_owner,
                                        :repo_name => repo_name)

    Sem::Views::Projects.create(project)
  rescue Sem::Helpers::Git::InvalidGitUrl
    abort "Git URL #{options[:url]} is invalid."
  end

  class SharedConfigs < Dracula
    desc "list", "list shared configurations on a project"
    def list(project)
      org_name, project_name = Sem::SRN.parse_project(project)

      configs = Sem::API::SharedConfigs.list_for_project(org_name, project_name)

      Sem::Views::SharedConfigs.list(configs)
    end

    desc "add", "attach a shared configuration to a project"
    def add(project, shared_config)
      project_org_name, project_name = Sem::SRN.parse_project(project)
      shared_config_org_name, shared_config_name = Sem::SRN.parse_shared_config(shared_config)

      if project_org_name != shared_config_org_name
        abort Sem::Views::Projects.org_names_not_matching("project", "shared configuration", project, shared_config)
      end

      Sem::API::SharedConfigs.add_to_project(project_org_name, project_name, shared_config_name)

      puts "Shared Configuration #{project_org_name}/#{shared_config_name} added to the project."
    end

    desc "remove", "removes a shared configuration from the project"
    def remove(project, shared_config)
      project_org_name, project_name = Sem::SRN.parse_project(project)
      shared_config_org_name, shared_config_name = Sem::SRN.parse_shared_config(shared_config)

      if project_org_name != shared_config_org_name
        abort Sem::Views::Projects.org_names_not_matching("project", "shared configuration", project, shared_config)
      end

      Sem::API::SharedConfigs.remove_from_project(project_org_name, project_name, shared_config_name)

      puts "Shared Configuration #{project_org_name}/#{shared_config_name} removed from the project."
    end
  end

  register "shared-configs", "manage shared configurations", SharedConfigs

end
