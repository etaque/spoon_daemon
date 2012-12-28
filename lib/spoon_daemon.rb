require "spoon"
require "timeout"

require "spoon_daemon/version"

module SpoonDaemon
  class Runner
    def initialize(script, cmd, options = {})
      @script = script

      @pid_dir = options[:pid_dir] || '.'
      @name = options[:name] || File.basename(script)
      @timeout = options[:timeout] || 10

      @pid_path = File.join(@pid_dir, "#{@name}.pid")
      @pid = get_pid

      case cmd
      when 'start'
        start
      when 'stop'
        stop
      when 'restart'
        stop
        start
      else
        STDERR.puts "Usage: <script> <start|stop|restart>"
        exit!
      end
    end

    def create_pid(pid)
      begin
        open(@pid_path, 'w') do |f|
          f.puts pid
        end
      rescue => e
        STDERR.puts "Error: Unable to open #{@pid_path} for writing:\n\t" +
            "(#{e.class}) #{e.message}"
        exit!
      end
    end

    def get_pid
      pid = nil
      open(@pid_path, 'r') do |f|
        pid = f.readline.to_s.gsub(/[^0-9]/,'')
      end
      pid.to_i
    rescue Errno::ENOENT => e
      nil
    end

    def remove_pidfile
      File.unlink(@pid_path)
    rescue => e
      STDERR.puts "ERROR: Unable to unlink #{@pid_path}:\n\t" +
        "(#{e.class}) #{e.message}"
      exit
    end

    def process_exists?
      return false unless @pid
      Process.kill(0, @pid)
      true
    rescue Errno::ESRCH, TypeError # "PID is NOT running or is zombied
      false
    rescue Errno::EPERM
      STDERR.puts "No permission to query #{@pid}!";
      false
    end

    def stop
      abort "No process running, nothing to stop"  unless process_exists?

      begin
        STDOUT.puts "Stopping process #{@pid}..."
        Timeout.timeout(@timeout) do
          Process.kill("TERM", @pid)
          sleep 1 while process_exists?
        end
      rescue Timeout::Error
        STDERR.puts "Graceful shutdown timeout, sending KILL signal"
        Process.kill("KILL", @pid)
      end

      remove_pidfile
      STDOUT.puts "Process stopped."
    end

    def start
      abort "Process already running!" if process_exists?
      abort "Script not executable!" unless File.executable?(@script)
      if pid = Spoon.spawnp(@script)
        create_pid(pid)
        STDOUT.puts "Process running with pid #{pid}"
      else
        Process.setsid
      end
    end
  end
end
