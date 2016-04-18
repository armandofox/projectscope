class PivotalTracker < ActiveRecord::Base
  belongs_to :project
  
  def get_data
    begin
      client = TrackerApi::Client.new(token: ENV['PIVOTAL_TRACKER_TOKEN'])
      project = client.project(self.tracker_id.to_i)
      green, yellow, red, black = 0, 0, 0, 0
      green += project.stories(with_state: :accepted||:delivered||:finished).size
      yellow += project.stories(with_state: :started||:planned).size
      red += project.stories(with_state: :unstarted||:unscheduled).size
      pt_hash = {done: green, new: yellow, old: red, older: black}
    rescue TrackerApi::Error
      pt_hash = {done: -1, new: -1, old: -1, older: -1}
    ensure
      self.update_attributes(pt_hash)
    end
  end

end