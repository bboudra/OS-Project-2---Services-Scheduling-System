require 'thread'
##
# This class will hold the list of dentist offices
#
# * *Author*
#   -Benjamin Boudra
class DentistOffice
  @@lock = Mutex.new

  def initialize
    @office_list = {}
    @office_list['Office 1'] = 2001
  end

  ##
  # Retrieves the server port number for a given office
  #
  def get_office_port(office_name)
    @@lock.synchronize {
      @@office_list[office_name]
    }
  end

  ##
  # Gets he list of doctors offices that communicate with the caller and returns them to the user
  def get_dentist_offices()
    @@lock.synchronize {
      return @@office_list.keys
    }
  end

  ##
  # Adds a office port combination to the offices list and returns them to the caller.
  #
  # * *Args* :
  #   - +office_name+ -> The name of the Dentist office to be added
  #   - +port+ -> The port number that the Dentist office is listening to
  #
  # * *Returns* :
  #
  def add_offices(office_name, port)
    @@lock.synchronize {
      if !(@office_list.has_key?(office_name))
        @@office_list[office_name] = port
      end
    }
  end
end