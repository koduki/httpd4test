require 'webrick'
require 'optparse'

params = Hash[ARGV.getopts('p:m:w:h', 'port:', 'message:', 'interval:', 'json', 'help').
                map { |k, v| [k.to_sym, v] }]

port = if params[:p] != nil
        params[:p].to_i
    elsif params[:port] != nil
        params[:port].to_i
    else
        8080
    end
msg = if params[:m] != nil
        params[:m]
    elsif params[:message] != nil
        params[:message]
    else
        nil
    end

interval = if params[:interval] != nil
        params[:interval].to_i
    else
        0
end

is_json = params[:json]
is_help = params[:h] || params[:help]

if is_help
    puts "Usage: httpd4test [OPTION]..."
    puts "This is http server for testing"
    puts "Options:"
    puts "\t-p, --port\t\t port number of http server"
    puts "\t-m, --message\t\t echo message"
    puts "\t-w \t\t\t set workdir"
    puts "\t--interval \t\t set time interval (ms)"
    puts "\t-h, --help\t\t show this message"
    puts "\t--json\t\t\t change content-type to 'application/json'"
    exit
end

server = WEBrick::HTTPServer.new({ 
    :SSLEnable => false,
	:DocumentRoot => './',
	:Port => port
})

if msg
    server.mount_proc '/' do |req, res|
        puts "Wait time interval: #{interval}"
        sleep(interval / 1000.0)
        if is_json
            res.header['Access-Control-Allow-Origin'] = '*'
            res.header['Access-Control-Allow-Headers'] = 'X-Requested-With, Origin, X-Csrftoken, Content-Type, Accept'
            res.header['Content-Type'] = 'application/json'
        end
        url_params = req.path.sub('/', '').split('/')
        
        body = msg
        (0..(url_params.size-1)).each do |i| 
            body = body.gsub('#{' + (i + 1).to_s + '}', url_params[i]) 
        end
        res.body = body
    end
end

puts "Server is listening on :#{port}"
if msg
    puts "Return value is #{msg}"
    puts "Time interval is #{interval} ms"
else
    puts "Return local contents"
end
trap 'INT' do server.shutdown end
server.start