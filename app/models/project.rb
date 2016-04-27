class Project < ActiveRecord::Base
  
  has_one :pull_request
  has_one :slack_metric
  has_one :code_climate_metric
  has_one :pivotal_tracker
  has_many :slack_data_points, through: :slack_metric
  
  
  def get_scores
    ccm = self.code_climate_metric
    gpa = ccm.gpa
    #self.gpa!
    coverage = ccm.coverage
    #self.prs = PullRequest.where(:project_id == self.id).get_score
    
    #pts = self.pivotal_tracker.get_score
    self.update_attributes(:gpa => gpa, :coverage => coverage, :pts => pts)

  end
  
  
end
