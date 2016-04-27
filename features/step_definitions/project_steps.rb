Then(/^I should see a graphic representing (.*?) metrics in a row of the projects table$/) do |metric|
  page.should have_content(metric)
  # page.should have_xpath("//td/div[@class='graphic']")
end

Then /^I should see a graphic showing (.*)$/ do |thing|
  fail "Unimplemented"
end

Then /^I should see their badge from (.*)$/ do |service|
  # Figure this out for Iteration 2-2
  fail "Unimplemented"
end

Given(/^I create a new project named "([^"]*)" with the git repo "([^"]*)"$/) do |project_name, repo_name|
  proj = Project.create(name: project_name)
  proj.create_pull_request(repo: repo_name)
end

Then(/^I should see the "([^"]*)" (.*) graphic$/) do |project_name, metric|
  project_id = Project.find_by(name: project_name).id
  expect(page).to have_selector('#'+ project_id.to_s + '-' + metric.gsub(' ', '-'))
end

Then(/^I should see the total number of pull requests for "([^"]*)"$/) do |project_title|
  project_id = Project.find_by(name: project_title).id
  expect(page).to have_selector('#project-' + project_id.to_s + '> td:nth-child(2) > div:nth-child(3)')
end

Given(/^the following projects exist:$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  #table.hashes.each do |project_hash|
  #  # each returned element will be a hash whose key is the table header.
  #  # you should arrange to add that movie to the database here.
  #  project = Project.create(name: project_hash[:name])
  #  project.create_pull_request(repo: project_hash[:repo])
  #  project.create_pivotal_tracker()
  #  project.create_code_climate_metric
  table.hashes.each do |project_hash|
    proj = Project.create(name: project_hash[:name])
    proj.create_pull_request(repo: project_hash[:repo])
    proj.create_pivotal_tracker(tracker_id: project_hash[:tid])
    code_climate_url = "https://codeclimate.com/github/#{project_hash[:repo]}"
    proj.create_code_climate_metric(url: code_climate_url)
    proj.create_slack_metric(slack_api_token: '')
  end
end

Then(/^the projects should be sorted by pull requests$/) do
  sorted_projects = PullRequest.order(:red, :yellow, :green).map { |pr| pr.project }
  sorted_projects.each_cons(2) do |chunk|
    expect(page.body.index(chunk[0].name)).to be < page.body.index(chunk[1].name)
  end
end

Then(/^the projects should be sorted by Code Climate GPA$/) do
  sorted_projects = CodeClimateMetric.order(:gpa).map { |pr| pr.project }
  sorted_projects.each_cons(2) do |chunk|
    expect(page.body.index(chunk[0].name)).to be < page.body.index(chunk[1].name)
  end
end

Then(/^the projects should be sorted by name$/) do
  sorted_projects = Project.all.order(:name)
  sorted_projects.each_cons(2) do |chunk|
    expect(page.body.index(chunk[0].name)).to be < page.body.index(chunk[1].name)
  end
end
