require 'socket'
require_relative 'dentist_office'

##
# A class designed to handle the registrar's operations at a thread level
#
# * *Author* :
#   - Benjamin Boudra
class RegistrarThread
  END_OF_MESSAGE = "END OF MESSAGE"

  def initialize(client)
    @client = client
    @office = DentistOffice.new
  end

  ##
  # Handles the registrar's operations at a thread level.
  #
  def run
    initial_request = ""
    while initial_request != 'EXIT'
      initial_request = @client.gets.chomp
      case initial_request
        when 'GET DENTIST OFFICE'
          reply_to_request = @office.get_dentist_offices
          reply_to_request.each { |line|
            @client.puts(line)
          }
          @client.puts(END_OF_MESSAGE)
        when 'VIEW TIMES'
          self.view_times
        when 'ADD APPOINTMENT'
          self.add_appointment
        when 'EXIT'
          @client.close
        else
      end
    end
  end

    def view_times()
      message = self.receive_multi_line_message(@client)
      destination = @office.get_office_port(message[0])
      s = TCPSocket.open(destination[0], destination[1])
      message = message[1...message.length]
      self.send_multi_line_message(s, message)
      response = receive_multi_line_message(s)
      response.each do |line|
        puts(line)
      end
      self.send_multi_line_message(@client, response)
    end

    def add_appointment()
      message = self.receive_multi_line_message(@client)
      the_port = @office.get_office_port(message[0])
      s = TCPSocket.open('localhost', the_port)
      message = message[1...message.length]
      self.send_multi_line_message(s, message)
      response = receive_single_line_message(s)
      self.send_single_line_message(@client, response)
    end


    def send_single_line_message(socket, message)
      socket.puts(message)
    end

    def receive_single_line_message(socket)
      message = socket.gets(message)
      return message
    end

    def send_multi_line_message(socket, message)
      message.each { |line|
        socket.puts(line)
      }
      socket.puts(END_OF_MESSAGE)
    end

    def receive_multi_line_message(socket)
      message = []
      line = ""
      until line == END_OF_MESSAGE
        line = socket.gets.chomp
        message.push(line)
      end
      return message[0...message.length - 1]
    end
  end
