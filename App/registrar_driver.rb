require_relative 'registrar/registrar_thread'
require 'socket'

##
# starts and manages the registrar threads
class RegistrarDriver

  ##
  # Initializes the registrar.
  #
  # * *Args* :
  #
  # * *Returns* :
  #
  def initialize
    @registrar= TCPServer.open(2000)
  end

  ##
  # Handles registrar operations at a multi-threaded level
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