class Job < ActiveRecord::Base
    belongs_to :screen
    belongs_to :command
    belongs_to :user

    attr_accessor :target_string

    before_save :set_target
    validate :check_datetime

    def check_datetime
        errors.add(:target, "must be in the future") if (self.target || Time.zone.parse(self.target_string)) < Time.now
    end

    def set_target
        self.target = Time.zone.parse(self.target_string) if self.target_string
    end

    def target_str
        self.target.strftime("%Y-%m-%d %l:%M %p")
    end

    def old?
        self.target < Time.now && !removable
    end

    def executable
        self.command.data.gsub('%%%', self.arguments)
    end
end
