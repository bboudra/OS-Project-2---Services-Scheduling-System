##
# acts as an interface between the user and the registrar to obtain and display informaiton to the client.
class Client
  ##
  # This method will take in the users date, the time that the appointment begins, and the time that the appointment ends.
  # if the time slot is still available. The program will output a message that the appointment was scheduled. If the
  # timeslot is taken, an appropriate error message will be output.
  #
  # * *Args*  :
  #   - +date+ -> the desired date of the appointment.
  #   - +doctor+ -> The doctor you wish to use.
  #   - +start_time+ -> the beginning the desired appointment time.
  #   - +end_time+ -> the time that the appointment ends, in most cases, will be calculated by using the start time and the appointment length appointment length.
  # * *Returns* :
  #   - The message stating whether or not the appointment was successful.
  def make_appointment(date, doctor, start_time, end_time)
  end

  ##
  # Given a specified doctor, date, and appointment_length, this method will return the list of a particular doctor's
  # on that particular date for an appointment of that length.
  #
  # * *Args* :
  #   - +date+ -> the desired date of the appointment.
  #   - +doctor+ -> the desired doctor
  #   - +appointment_length+ -> The length ofthe desired appointment
  #
  # * *Returns* :
  #   - The list of available appointment times for that day, doctor, and appointment length
  def get_available_times(date, doctor, appointment_length)

  end

  ##
  # Gets the date, doctor, and availability informaiton from the user unless the information is passed in as a
  # parameter. Allows the information to be passed in as a parameter for the purposes of automated testing.
  #
  # * *Args* :
  #   - +date+ -> the date that the user wishes to check for availability
  #   - +doctor+ -> the doctor that the user wishes to see on that date.
  #   - +appointment_length+ -> the length of the appointment the client needs to have, will be determined by appointment type
  # * *Returns* :
  #   - the avalibility information that was either entered by the user or passed in from outside, then verified inside the method
  def get_availability_information_from_user(date = nil, doctor = nil, appointment_length = nil)

  end
  ##
  # receives the time as a string and verifies that the format is accurate.
  #
  # * *Args* :
  #   - +string_time+ -> the time as a string
  # * *Returns* :
  #   - true if string is properly formatted, false if it is not
  def string_properly_formatted?(string_time)
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


  ##
  # Receives a float in military time and returns that time to the caller.
  #
  # * *Args* :
  #   - +float_military_time+ -> the float in military time format
  # * *Returns*
  #   - true if time is valid, false if it is not
  def valid_time?(float_military_time)
    valid_number = true
    if 6.00 <=float_military_time && float_military_time <= 20.00
      if (float_military_time - float_military_time.to_i.to_f) == 0.0
        return valid_number
      end
      if (float_military_time - float_military_time.to_i.to_f) == 0.25
        return valid_number
      end
      if (float_military_time - float_military_time.to_i.to_f) == 0.50
        return valid_number
      end
      if (float_military_time - float_military_time.to_i.to_f) == 0.75
        return valid_number
      end
    end
    return !(valid_number)
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

end