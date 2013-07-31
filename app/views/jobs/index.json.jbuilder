json.array!(@jobs) do |job|
  json.extract! job, :screen_id, :command_id, :arguments, :user_id, :target
  json.url job_url(job, format: :json)
end
