require_relative 'registrar/registrar_thread'
require 'socket'

class RegistrarDriver

  def initialize
    @registrar= TCPServer.open(2000)
  end

  def run
    loop do # Servers run forever
      Thread.start(@registrar.accept) do |client|
        @registrar_thread = RegistrarThread.new(client)
        @registrar_thread.run
      end
    end
  end
end

@registrar_driver = RegistrarDriver.new
@registrar_driver.run