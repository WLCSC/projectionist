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
        q = jobs.where("target < ?", Time.zone.now).order('target').all
        while q.length > 1
            q.first.delete
        end
        begin
            connect
            @remote.execute(q.first.executable)
        rescue
            puts "Oops - couldn't run on #{address}"
        end
    end

    def connect
        there = "druby://#{address}:9821"
        DRb.start_service nil, nil
        @remote = DRbObject.new nil, there
    end

    def ping
        begin
            connect
            @remote.ping
        rescue
            "Ping Failed. #{$!}"
        end
    end
end
