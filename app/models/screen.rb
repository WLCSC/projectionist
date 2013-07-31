require 'drb'

class Screen < ActiveRecord::Base
    has_many :jobs
    has_many :schedules
    has_many :installations
    has_many :commands, :through => :installations

    def display
        self.name
    end

    def push_job
        connect
        q = jobs.where("target < ?", Time.zone.now).order('target').all
        while q.length > 1
            q.first.delete
        end
        @remote.execute(q.first.executable)
    end

    def connect
        there = "druby://#{address}:8787"
        DRb.start_service nil, nil
        @remote = DRbObject.new nil, there
    end
end
