=begin
class Doctors

  ##
  # Initializes te class and builds the list of doctors.
  def initialize
    @doctors = []
    @doctors.push("First Doctor")
    @doctors.push("Second Doctor")
    @doctors.push("Third Doctor")
    @doctors.push("Fourth Doctor")
    @doctors.push("Fifth Doctor")
    @doctors.push("Sixth Doctor")
  end
  ##
  # This method will retrieve the list of doctors when called.
  #
  # * *Args* :
  #
  # * *Returns* :
  #   - the list of doctors
  def get_doctors()
    return @doctors
  end

  ##
  # This method will determine whether or not a doctor exists.
  #
  # * *Args* :
  #   - +doctor_name+ -> the name of the doctor
  #
  # * *Returns* :
  #   - true if doctor exists
  #   - false if the doctor does not exist
  def doctor_exists?(doctor_name)
    @doctors.each do |doctor|
      if doctor_name == doctor
        return true
      end
    end
    return false
  end

end
=end