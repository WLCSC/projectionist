require 'drb'
require 'socket'


here = "drb://#{Socket.gethostname}:8787"

exe = Object.new

def exe.execute(str)
    puts "Running <#{str}>"
    `kill.bat`
    sleep(1)
    Thread.new(str) {|c| `#{c}`}
end

DRb.start_service here, exe
DRb.thread.join

