require 'drb'
require 'socket'


here = "druby://#{Socket.gethostbyname(Socket.gethostname).first}:9821"

exe = Object.new

def exe.execute(str)
    puts "Running <#{str}>"
    `kill.bat`
    sleep(1)
    Thread.new(str) {|c| `#{c}`}
end

DRb.start_service here, exe
puts "Running #{here}"
DRb.thread.join

