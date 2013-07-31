class Installation < ActiveRecord::Base
    belongs_to :screen
    belongs_to :command
end
