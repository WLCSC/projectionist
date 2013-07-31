class Schedule < ActiveRecord::Base
    belongs_to :screen
    belongs_to :user
    belongs_to :command
end
