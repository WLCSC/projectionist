class Schedule < ActiveRecord::Base
    belongs_to :screen
    belongs_to :user
    belongs_to :command

    attr_accessor :offset_string

    before_save :set_offset
    validates_each :command_id do |record, attr, value|
        record.errors.add(attr, "is not valid for this screen") unless record.screen.command_ids.include?(value)
    end

    def set_offset
        matchdata = self.offset_string.match(/(\d\d):(\d\d) (A|P)M/)
        h = (matchdata[3] == 'A' ? 0  : 12 )
        h += matchdata[1].to_i
        m = matchdata[2].to_i
        m += h * 60
        self.offset = m
    end

    def offset_str
        m = offset % 60
        h = offset / 60
        p = "A"
        if h > 12
            h -= 12
            p = "P"
        end
        m = m.to_s
        h = h.to_s
        m = m.rjust(2, '0')
        h = h.rjust(2, '0')

        "#{h}:#{m} #{p}M"
    end

    def to_job(date)
        Job.new :command => self.command, :screen => self.screen, :arguments => self.arguments, :user => self.user, :removable => nil, :target => date.midnight + (self.offset.minutes)
    end
end
