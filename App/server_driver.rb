require 'socket'
require_relative '../App/server/server_thread'
##
# Starts the server operations
#
class ServerDriver
  def initialize(port)
    @server = TCPServer.open(port)
  end

  ##
  # Handles server operations at a multithreaeded level
  def run
    loop do # Servers run forever
      Thread.start(@server.accept) do |client|
        @server_thread= ServerThread.new(client)
        result = @server_thread.run()
        result.each do |line|
          client.puts(line)
        end
        client.close
      end
    end
  end
end

server_driver = ServerDriver.new(2001)
server_driver.run()