require 'json'
require 'socket'
require 'open-uri'


def here
	@here ||= Socket.gethostname
end

def execute(str)
    puts "Running <#{str}>"
    `./kill.bat`
    sleep(1)
    Thread.new(str) {|c| puts `#{c}`}
end

@there = ARGV[0]
open(@there) do |f|
    @screens = JSON.parse(f.read)
end
puts "Found #{@screens.count} screens: #{@screens.map{|x| x['address']}.join(', ')}"
@screens.select!{|x| x['address'] == here}
if @screens.length > 0
    @url = @screens[0]['url'] 
    open(@url) do |f|
        @screen = JSON.parse(f.read)
    end
    puts "I am screen #{@screen['name']}"
    begin
    @current_id = @screen['job']['id']
    rescue
	    puts @screen.to_json
    end
    execute @screen['job']['executable']
else
    puts "[#{here}] is not a registered screen.  Goodbye."
    exit
end

while true
    sleep(1*60)
    open(@url) do |f|
        @screen = JSON.parse(f.read)
    end
    if @current_id != @screen['job']['id']
        @current_id = @screen['job']['id']
        execute @screen['job']['executable']
    end
end
