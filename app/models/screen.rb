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
        q = jobs.where("target < ?", Time.zone.now).order('target').to_a
        while q.length > 1
            q.first.delete
            q.delete_at(0)
        end
        begin
            connect
            j = q.delete_at(0)
            @remote.execute(j.executable) unless j.removable == true
            j.removable = true
            j.save
        rescue
            puts "Oops - couldn't run on #{address}"
            puts $!
            puts $@
        end
    end

    def connect
        DRb.start_service nil, nil
        @remote ||= DRbObject.new nil, "druby://#{address}:9821"
    end

    def ping
        begin
            connect
            @remote.ping
        rescue
            "Ping Failed. #{$!}"
        end
    end

    def generate_daily_jobs
        self.schedules.each do |s|
            s.to_job(Time.zone.now).save
        end
    end
end
