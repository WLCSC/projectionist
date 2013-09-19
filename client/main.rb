require 'json'
require 'socket'
require 'open-uri'


def here
	@here ||= "druby://#{Socket.gethostbyname(Socket.gethostname).first}:9821"
end

def execute(str)
    puts "Running <#{str}>"
    `kill.bat`
    sleep(1)
    Thread.new(str) {|c| `#{c}`}
end

@there = ARGV[0]
open(@there) do |f|
    @screens = JSON.parse(f.read)
end

@screens.select!{|x| x.address == here}
if @screens.length > 0
    @url = @screens[0]['url'] 
    open(@url) do |f|
        @screen = JSON.parse(f.read)
    end
    puts "I am screen #{@screen['name']}"
    @current_id = @screen['job']['id']
    execute @screen['job']['executable']
else
    puts "This is not a registered screen.  Goodbye."
    exit
end

while true
    sleep(5*60)
    open(@url) do |f|
        @screen = JSON.parse(f.read)
    end
    if @current_id != @screen['job']['id']
        @current_id = @screen['job']['id']
        execute @screen['job']['executable']
    end
end
