require 'drb'
require 'socket'



exe = Object.new

def exe.here
	@here ||= "druby://#{Socket.gethostbyname(Socket.gethostname).first}:9821"
end

def exe.execute(str)
    puts "Running <#{str}>"
    `kill.bat`
    sleep(1)
    Thread.new(str) {|c| `#{c}`}
end

def exe.ping
	puts "I've been pinged."
	"Projectionist client #{@here} responding at #{Time.now.to_s}."
end

DRb.start_service exe.here, exe
puts "Running #{exe.here}"
DRb.thread.join

