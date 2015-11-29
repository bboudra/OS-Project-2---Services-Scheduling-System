require 'singleton'
require_relative 'registrar/registrar_thread'
require 'socket'
class RegistrarDriver
    include Singleton

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

@registrar_driver = RegistrarDriver.instance
@registrar_driver.run