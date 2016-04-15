json.array!(@pivotal_trackers) do |pivotal_tracker|
  json.extract! pivotal_tracker, :id, :done, :new, :old, :older, :tracker_id, :project_id
  json.url project_pivotal_tracker_url(pivotal_tracker.project, pivotal_tracker, format: :json)
end