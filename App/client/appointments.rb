class Appointments
  def initialize
    @appointments = {}
    @appointments["Quick Checkup"] = 0.25
    @appointments["Basic Checkup"] = 0.50
    @appointments["Physical"] = 0.75
    @appointments["Special Service"] = 1.00
    @appointments["Surgry"] = 2.00
  end

  def appointment_type_exists?(appointment_type)
    return @appointments.has_key?(appointment_type)
  end

  def get_appointment_types
    return @appointments.keys
  end

  def get_appointment_length(appointment_type)
    return @appointments[appointment_type]
  end
end