require 'json'
require 'socket'
require 'open-uri'


module OS
    def OS.windows?
        (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end

    def OS.mac?
        (/darwin/ =~ RUBY_PLATFORM) != nil
    end

    def OS.unix?
        !OS.windows?
    end

    def OS.linux?
        OS.unix? and not OS.mac?
    end
end

def here
    @here ||= Socket.gethostname
end

def execute(str)
    puts "Running <#{str}>"
    if OS.windows?
        `./kill.bat`
    else
        `./kill.sh`
    end
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
    puts "This is screen #{@screen['name']}"
    if @screen['job']
        @current_id = @screen['job']['id']
        execute @screen['job']['executable']
    else
        puts "No current job available."
    end
else
    puts "[#{here}] is not a registered screen.  Goodbye."
    exit
end

while true
    begin
    sleep(1*60)
    open(@url) do |f|
        @screen = JSON.parse(f.read)
    end
    if @current_id != @screen['job']['id']
        @current_id = @screen['job']['id']
        execute @screen['job']['executable']
    end
    rescue => ex
        puts ex.message
        File.open('error-log.txt', 'a') do |f|
            f << "At #{Time.now.to_s}:\n"
            f << ex.message << "\n"
            f << ex.backtrace
            f << "\n\n"
        end
    end
end
