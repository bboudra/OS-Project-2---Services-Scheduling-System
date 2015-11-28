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
  # Given a specified doctor, date, and appointment_length, this method will return the list of a particular doctor's availability
  def get_available_times(date, doctor, appointment_length)

  end

  def check_string_time_format(string_time)
  end

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

  private
  def break_into_pieces(string_time)
    time_array = string_time.split(':')
    time_array[0] = time_array[0].to_i
    time_array[1] = time_array[1].to_i
    return time_array
  end

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
end