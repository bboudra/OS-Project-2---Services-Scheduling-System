require_relative '../App/client/client'

##
# starts and controls the client operations
#
# * *Author* :
#   - Benjamin Boudra ->
#
class ClientDriver

  ##
  # runs the client
  #
  # * *Args* :
  #
  # * *Returns* :
  #
  def start_run
    client = Client.new
    puts 'Hello, welcome to the Services Scheduling System'
    client.make_appointment
  end
end

ClientDriver.new.start_run()
