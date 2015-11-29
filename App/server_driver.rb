require 'socket'
class ServerDriver
  def initialize(port)
    @server = TCPServer.open(port)
  end

  def run
    loop do # Servers run forever
      Thread.start(@server.accept) do |client|
        #@server_thread= RegistrarThread.new(client)
        #@server_thread.run
        print "I reached Here!!!!"
      end
    end
  end
end

server_driver = ServerDriver.new(2001)
server_driver.run