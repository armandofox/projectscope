# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

moonlighter = Project.create(name: 'ER Moonlighter Scheduling')
moonlighter.create_pull_request(repo: 'stevenbuccini/er-moonlighter-scheduler')
moonlighter.create_slack_metric(slack_api_token: '')
moonlighter.create_pivotal_tracker(tracker_id: '1282128')

project_data = [
  ['Rate My Pup', 'eabartlett/ratemypup/', '1276210'],
  ['Artist Submission Site', 'cal-sfai/submission-site', '1282990'],
  ['Database and development site for City Dog Share', 'sfstanley/citydogshare', '1281750'],
  ['UC Berkeley Food Pantry App', 'michellelinggg/UCBerkeleyFoodPantry', '1282596'],
  ['Maker Pass Admin System', 'MasonIII/cal-maker-pass', '1285842'],
  ['Calendar Creation, Synchronization', 'calendar-makers/calendar-sync', '1281740'],
  ['Mobile Intake App for BCEF', 'Berkeley-BCEF/IntakeApp', '1282432'],
  ['Optimization of Volunteer Database for Hep B Project', 'navroopsingh/HepBProject', '1282904'],
  ['Mass Spectrometry Tools', 'avadordi/mass-spectrometry', '1285770'],
  ['Assessment Platform', 'cs169-bizworld/bizworld-app', '1286372'],
  ['Course Question Bank', '', ''],
  ['CS 61AS Quiz System', 'cs169team61as/cs61as-quiz-system', 'INVALID'],
  ['Automate Vendor Signup Forms on SFVS.org website', 'neilkumar101/CS169_SFVS', '1282818'],
  ['Khan Academy Burmese', 'DarryQueen/Khan-Burmese', '1283294'],
  ['Berkeley Student Coop Workshift Website', 'bsc-networks/workshift-website', '1283294'],
  ['Healthy EFF', 'ashleywillard/healthy-eff', '1283294'],
  ['PenPal Gladiators', 'Fong-/CS169-PenPal-Gladiators', '1286520'],
  ['SNAP', 'snap-cloud/snap-cloud', '1284734'], 
  ['News Tab Website', '', '1282358'],
  ['Jacobs Institute Project Documentation', 'jacobs-design/jortal', '1282960'], 
  ['Youth Media Tracker/Uploader', 'hamzahashmi/youth-media-tracker', '1279044'], 
  ['Practice Problem Portal', 'yujuncho7/practice-problem-portal', '1281582'], 
  ['Lab assistant check-in', 'vincenttian/61A-Lab-Assistant', '1282890'], 
  ['OK-Grading addition', 'joseph-choi/ok', '1283428'], 
  ['Language Exchange Program Algorithm', 'swchoi727/LEP', '1277228'], 
  ['Cal Central', 'Garyguo2011/CalCentral-Task-Planner.git', '1283320'],
  ['Volunteer and Space rental portal integration', 'mleong245/bhnc-portal', '1269296'], 
  ['Tracking the flow of donations of a nonprofit organization', 'donaldchen/TWC_Inventory_Tracker', '1281660'], 
  ['Dogs who code', 'graceeekimmm/dogswhocode/', '1281660'], 
  ['Peer Tracker', 'imranyousuf/PeerTracker', '1282782'], 
  ['DeCal Program Website', 'ericcquachh/decal', '1276244'], 
  ['Staffoution', 'hpec/staffolution', '1276244'], 
  ['Koin Rides', 'wesley-hsu/KoinRides', '1285688'], 
  ['Saffron Strand Website Redevelopment', '', '1286582'],
  ['Oski Survey', 'uc-swirl/surveyoski/', '1282482'],
  ['College Track Student Portal', 'forgottn/collegetrack_portal', '1302750'], 
  ['Revamp Project Portal', 'chrisbrown/project-portal', '1282510'], 
  ['Haas Career Management Legend', 'huangshan108/CareerNet', '1282836'], 
  ['Redeemify', '', ''], 
  ['ER Core Staff Scheduler', 'charlespark94/ER-Core-Staff-Scheduler', '1284480'],
]

project_data.each do |p|
  proj = Project.create(name: p[0])
  proj.create_pull_request(repo: p[1])
  proj.create_pivotal_tracker(tracker_id: p[2])
  proj.create_slack_metric(slack_api_token: '')
  
  
  code_climate_url = "https://codeclimate.com/github/#{repo}"
  if repo == ""
    code_climate_url = ""
  end
  proj.create_code_climate_metric(url: code_climate_url)
  
  num_slack_users = 5 + rand(2)
  rand_msg_counts = num_slack_users.times.map{ rand(200) }
  rand_msg_counts.each do |count|
    rand_name = (0...8).map { (65 + rand(26)).chr }.join
    proj.slack_metric.slack_data_points.create(user: rand_name, messages: count)
  end
end
