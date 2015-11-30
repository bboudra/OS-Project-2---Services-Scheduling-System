require 'socket'
require_relative 'dentist_office'

##
# A class designed to handle the registrar's operations at a thread level
#
# * *Author* :
#   - Benjamin Boudra
class RegistrarThread
  def initialize(client)
    @client = client
  end

  ##
  # Handles the registrar's operations at a thread level.
  #
  def run
    request = []
    result = ""
    while result != "End Of Message"
      result = @client.gets.chomp
      request.push(result)
    end
    case request[0]
      when 'GET_OFFICE_NAMES'

    end
    office = DentistOffice.new
    the_port = office.get_office_port(request[0])
    puts "Port #{the_port}"
    s = TCPSocket.open('localhost', the_port)
    new_message = request[1...request.length]
    new_message.each do |line|
      s.puts(line)
    end

    server_response = []
    server_response_line= ""
    until server_response_line == "End Of Message"
      server_response_line = s.gets.chomp
      server_response.push(server_response_line)
    end

    puts server_response
    server_response.each do |line|
      @client.puts(line)
    end

    request = []
    result = ""
    while result != "End Of Message"
      result = @client.gets.chomp
      request.push(result)
    end
    puts request
    the_port =
    s = TCPSocket.open('localhost', the_port)
    new_message = request[1...request.length]
    puts new_message

    new_message.each do |line|
      s.puts(line)
    end
    server_response = []
    server_response_line= ""
    server_response_line = s.gets.chomp
    server_response.push(server_response_line)
    puts server_response
    server_response.each do |line|
      @client.puts(line)
    end
    @client.close
  end

  ##
  # Helper method to retrieve a port given a specific office - written because dentist office is not functioning correctly
  #
  # * *Args* :
  #   - +office_name+ -> the name of the office being searched for
  def get_office_port(office_name)
    if office_name == 'Office 1'
    end
  end

end
