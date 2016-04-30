class Project < ActiveRecord::Base
  
  has_one :pull_request
  has_one :slack_metric
  has_one :code_climate_metric
  has_one :pivotal_tracker
  has_many :slack_data_points, through: :slack_metric
  
  
  def get_scores
    ccm = self.code_climate_metric
    gpa = ccm.gpa
    coverage = ccm.coverage
    prs = (self.pull_request.green + (0.5 * self.pull_request.yellow))/self.pull_request.total
    pt = self.pivotal_tracker
    pts = pt.done + ((0.5 * pt.new) + (0.25 * pt.old))/(pt.done + pt.new + pt.old + pt.older)
    self.update_attributes(:gpa => gpa, :coverage => coverage, :prs => prs, :pts => pts)

  end
  
  
end
