module ProjectsHelper

    # Return entire github http string
    # repo_name format: USER/PROJECT
    # Assumes valid repo_name format
    def github_url(repo_name)
      "https://github.com/#{repo_name}"
    end

end
