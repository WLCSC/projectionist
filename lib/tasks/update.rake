task :push => :environment do
    Screen.all.each do |s|
        s.push_job
    end
end

task :generate => :environment do
    Screen.all.each do |s|
        s.generate_daily_jobs
    end
end

task :ping => :environment do
    Screen.all.each do |s|
        puts s.ping
    end
end
