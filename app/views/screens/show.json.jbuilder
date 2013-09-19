json.extract! @screen, :name, :description, :created_at, :updated_at
if @screen.current_job
    json.job @screen.current_job, :id, :executable 
end
