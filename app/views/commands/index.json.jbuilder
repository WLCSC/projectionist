json.array!(@commands) do |command|
  json.extract! command, :name, :notes, :data
  json.url command_url(command, format: :json)
end
