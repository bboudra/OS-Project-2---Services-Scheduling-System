require 'socket'
require_relative '../App/server/server_thread'
##
# Starts the server operations
#
# * *Author* :
# - Benjamin Boudra
class ServerDriver

  ##
  # initializes the server driver
  #
  # * *Args* :
  #   - the port the server is going to listen one
  #
  # * *Returns* :
  #
  def initialize(port)
    @server = TCPServer.open(port)
  end

  ##
  # Creates the server threads and manages their operations.
  #
  # * *Args* :
  #   -
  # * *Returns* :
  #
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

server_driver = ServerDriver.new(2005)
server_driver.run()