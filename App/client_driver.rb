require_relative '../App/client/client'
##
# starts client operations
class ClientDriver
  def start_run
    client = Client.new
    puts 'Hello, welcome to the Services Scheduling System'
    client.make_appointment
  end
end

ClientDriver.new.start_run()
