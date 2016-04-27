Feature: sort projects by metrics

  As an instructor
  So that I can see which projects are doing better in which project metrics
  I want to be able to sort projects based on each of the metrics

Scenario: sort by name, pull request, and GPA
  Given the following projects exist:
  | name                     | repo                                  | tid    |
  | Practice Problem Portal  | yujuncho7/practice-problem-portal     | 1281582|
  | ER Moonlighter Scheduling| stevenbuccini/er-moonlighter-scheduler| 1282128|
  | Healthy EFF              | ashleywillard/healthy-eff             | 1283294|
  | Automate Vendor Signup Forms on SFVS.org website |neilkumar101/CS169_SFVS| 1282818|

  When I am on the home page
  And I follow "Name"
  Then the projects should be sorted by name
  When I follow "GPA"
  Then the projects should be sorted by Code Climate GPA
  When I follow "Pull Requests"
  Then the projects should be sorted by pull requests
  
  