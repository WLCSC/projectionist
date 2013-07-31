class Job < ActiveRecord::Base
    belongs_to :screen
    belongs_to :command
    belongs_to :user

    attr_accessor :target_string

    before_save :set_target

    def set_target
        self.target = Time.zone.parse(self.target_string)
    end

    def target_string
        self.target.strftime("%Y-%m-%d %l:%M %p")
    end

    def old?
        self.target < Time.now
    end

    def executable
        self.command.data.gsub('\$', self.arguments)
    end
end
