json.array!(@schedules) do |schedule|
  json.extract! schedule, :screen_id, :command_id, :arguments, :user_id, :offset
  json.url schedule_url(schedule, format: :json)
end
