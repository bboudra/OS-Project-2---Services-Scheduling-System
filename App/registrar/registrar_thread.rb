require 'socket'
class RegistrarThread
  def initialize(client)
    @client = client
  end

  def run
    request = []
    result = ""
    while result != "End Of Message"
      result = @client.gets.chomp
      request.push(result)
    end
    the_port = 2001
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
    the_port = 2001
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

  def get_office_port(office_name)
    office_list['Office 1'] = 2001
    office_list[office_name]
  end
end
