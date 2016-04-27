class Project < ActiveRecord::Base
  has_one :pull_request
  has_one :slack_metric
  has_one :code_climate_metric
  has_one :pivotal_tracker
  has_many :slack_data_points, through: :slack_metric
  has_one :slack_trend
end
