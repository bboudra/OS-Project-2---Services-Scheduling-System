require_relative '../../lib/shared/appointments'
require_relative '../../lib/utilities/string'
require_relative '../../lib/utilities/utilities'
require 'date'
require 'socket'
##
# acts as an interface between the user and the registrar to obtain and display informaiton to the client.
class Client


  def initialize
    @s = TCPSocket.open('localhost', 2000)
  end

  ##
  # This method will take in the users date, the time that the appointment begins, and the time that the appointment ends.
  # if the time slot is still available. The program will output a message that the appointment was scheduled. If the
  # time slot is taken, an appropriate error message will be output.
  #
  # * *Args*  :
  #   - +date+ -> the desired date of the appointment.
  #   - +doctor+ -> The doctor you wish to use.
  #   - +start_time+ -> the beginning the desired appointment time.
  #   - +end_time+ -> the time that the appointment ends, in most cases, will be calculated by using the start time and the appointment length appointment length.
  # * *Returns* :
  #   - The message stating whether or not the appointment was successful.
  def make_appointment(date = nil, doctors_office = nil, start_time = nil, appointment_length = nil)
    list = get_availability_information_from_user
    print list
    @s.puts 'VIEW TIMES'
    message = list.insert(1, 'VIEW TIMES')
    result_message = get_available_times(message)
    choice = get_user_time_choice(result_message)
    if choice == -1
      return make_appointment
    end
    @s.puts('ADD APPOINTMENT')
    second_message = [list[0], 'ADD APPOINTMENT', message[2], message[3], choice, 'END OF MESSAGE']
    puts second_message
    second_message.each do |line|
      @s.puts(line)
    end
    line = @s.gets.chomp
    puts line
  end

  ##
  # display's appointment list, checks to make sure choice is in list of options, or -1 if they choose to pick a different day
  #
  # * *Args* :
  #   - +list_of_times+ -> the list of available times for that date, doctor's office, and appointment length
  #
  # * *Result* :
  #   - The time that the user would like to schedule their appointment if the user chooses to pick a time on that day
  #   - -1 if the user doesn't like any of the times for that day or there are no times for that day
  #
  def get_user_time_choice(list_of_times)
    list_of_times = list_of_times[0...list_of_times.length-1]
    if list_of_times.length == 0
      puts 'There are no times available for that day'
      return -1
    end
    option = 0
    puts '-1: None of the above.'
    list_of_times.each do |time|
      puts "#{option}: #{time}"
      option+= 1
    end
    choice = gets.chomp
    if -2 < choice.to_i && choice.to_i < list_of_times.length
      if choice == -1
        return -1
      else
        return list_of_times[choice.to_i]
      end
    else
      puts 'The option that was chosen was not valid, pleas enter a valid option'
      return get_user_time_choice(list_of_times)
    end
  end

  ##
  # Given a specified doctors office, date, and appointment_length, this method will return the list of a particular
  # doctors_office on that particular date for an appointment of that length.
  #
  # * *Args* :
  #   - +message+ -> the message containing doctor's office, date, appointment length and operation
  #
  # * *Returns* :
  #   - The list of available appointment times for that day, doctor's office, and appointment length
  def get_available_times(message)
    message.each do |line|
      puts line
    end
    self.send_multiline_message(@s,message)
    response_message = []
    line = ""
    until line == "END OF MESSAGE"
      line = @s.gets.chomp
      puts "#{line}"
      response_message.push(line)
    end

    response_message
  end

  ##
  # Gets the date, doctor, and availability information from the user unless the information is passed in as a
  # parameter. Allows the information to be passed in as a parameter for the purposes of automated testing.
  #
  # * *Args* :
  #   - +date+ -> the date that the user wishes to check for availability
  #   - +doctor+ -> the doctor that the user wishes to see on that date.
  #   - +appointment_type+ -> the type of the appointment the client needs to have
  # * *Returns* :
  #   - the avalibility information that was either entered by the user or passed in from outside, then verified inside the method
  def get_availability_information_from_user(date = nil, doctors_office = nil, appointment_type = nil)
    date = get_date() unless date
    doctors_office = get_dentists_office unless doctors_office
    appointment_type = get_appointment_type unless appointment_type
    unless valid_date?(date)
      puts "The date you entered is not valid, please enter a valid date"
      get_availability_information_from_user(nil, doctors_office, appointment_type)
    end
    unless valid_appointment_type?(appointment_type)
      puts "The type of appointment you entered, is not valid, please try again"
      get_availability_information_from_user(date, doctors_office)
    end
    appointments = Appointments.new
    appointment_length = appointments.get_appointment_length(appointment_type)
    return [doctors_office, date, appointment_length]
  end

  ##
  # Gets the desired appointment date from the user and returns it to the caller
  #
  # * *Args* :
  #
  # * *Returns* :
  #   - the users desired date (unvalidated)
  def get_date
    puts "Please enter the date you wish to schedule an appointment"
    puts "Use the form mm/dd/yyyy"
    return gets.chop()
  end

  ##
  # Gets the name desired doctors office from the user.
  #
  # * *Args* :
  #
  # * *Returns* :
  #   - the name of the doctors office
  def get_dentists_office
    @s.puts('GET DENTIST OFFICE')
    puts "i reached here"
    message = receive_multi_line_message(@s)
    puts "please select the number of the dentist office you wish to use"
    counter = 1
    message.each { |line|
      puts "#{counter}: #{line}"
      counter += 1
    }
    choice = gets.chomp
    if choice.is_i?
      choice = choice.to_i
      return message[choice-1]
    end
  end

  ##
  # Gets the appointment type from the user and returns it to the caller.
  #
  # * *Args* :
  #
  # * *Returns* :
  #   - the appointment type (unvalidated)
  def get_appointment_type
    appointments = Appointments.new
    puts "please select the number of the appointment type you wish to have"
    appointments_list = appointments.get_appointment_types
    counter = 1
    appointments_list.each do |appointment|
      puts "#{counter}: #{appointment}"
      counter += 1
    end
    choice = gets.chomp
    if choice.is_i?
      choice = choice.to_i
      return appointments_list[choice]
    end
  end

  ##
  # Receives a string that contains clock time and determines whether or not that
  # that time string is valid.
  #
  # * *Args* :
  #   - +time_string+ -> the float in military time format
  # * *Returns*
  #   - true if time is valid
  #   - false if time is not valid
  def valid_time?(time_string)
    if time_string =~ /\A([0]\d|1[012]):(00|15|30|45)\s(AM|PM)\z/
      return "#{time_string[0...2]}#{time_string[6...8]}"=~ /((0[6789]|1[012])AM|(0[1234567]PM))/
    end
  end


  ##
  # Receives the date as a string and verifies that the format and rang are valid.
  #
  # * *Args* :
  #   - +string_date+ -> the date as a string
  # * *Returns* :
  #   - true if the string is valid
  #   - false if the string is not valid
  def valid_date?(string_date)
    if string_date.length == 10
      condition_1 = string_date[0...2].is_i?
      condition_2 = string_date[2] == '/'
      condition_3 = string_date[3...5].is_i?
      condition_4 = string_date[5] == '/'
      condition_5 = string_date[6...10].is_i?
      if condition_1 && condition_2 && condition_3 && condition_4 && condition_5
        month = string_date[0...2].to_i
        day = string_date[3...5].to_i
        year = string_date[6...10].to_i
        if Date.valid_date?(year, month, day)
          if Date.new(year, month, day) > Date.today()
            return true
          end
        end
      end
    end
    return false
  end

  def valid_doctor?(doctor_name)
    doctors = Doctors.new
    return doctors.doctor_exists?(doctor_name)
  end

  def valid_appointment_type?(appointment_type_string)
    appointment = Appointments.new
    return appointment.appointment_type_exists?(appointment_type_string)
  end


  ##
  # Takes a time in string format and turns that time into a military time float
  #
  # * *Args* :
  #   - +string_time+ -> the time as a string
  # * *Returns* :
  #   - the time as a military time float.
  def convert_time_to_military_float(string_time)
    int_time_array = break_into_pieces(string_time)
    if (int_time_array[0] == 12.0)
      int_time_array[0] = int_time_array - 12
    end
    if (int_time_array[2] == 'PM')
      int_time_array[0] = int_time_array[0] + 12
    end
    int_time_array[1] = (int_time_array[1]*10) /6
    float_military_time = "#{int_time_array[0]}.#{int_time_array[1]}".to_f
    return float_military_time.round(2)
  end
  def send_multiline_message(socket,message)
    message.each { |line|
      socket.puts(line)
    }
    socket.puts("END OF MESSAGE")
  end


  private # all methods declared after this point are private
  ##
  # receives a string time in format hh:mm:(AM|PM) and returns an array containing the hour in location 0, the minute in location 1, and th second in location 2
  #
  # * *Args* :
  #   - +string_time+ -> The time in string format
  # * *Returns* :
  #   - an array with the hours, minutes, and AM/PM in their respective locations
  def break_into_pieces(string_time)
    time_array = string_time.split(':')
    time_array[0] = time_array[0].to_i
    time_array[1] = time_array[1].to_i
    return time_array
  end

  def receive_multi_line_message(socket)
    message = []
    line = ""
    puts "I reached here"
    until line == 'END OF MESSAGE'
      line = socket.gets.chomp
      message.push(line)
    end
    message = message[0...message.length - 1]
    return message
  end


end