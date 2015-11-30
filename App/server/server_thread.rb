require_relative '../server/schedule'
class ServerThread

  ##
  # initializes the server
  def initialize(client)
   @client = client
  end

  ##
  # runs the server operations at a thread level
  def run()
    list = []
    result = ""
    while result != "End Of Message"
      result = @client.gets.chomp
      list.push(result)
    end
    if list[0] == 'VIEW TIMES'
      schedule = Schedule.new
      result = schedule.get_free_times(list[1],list[2])
      return result
    else
      schedule = Schedule.new
      result = schedule.set_appointment(list[1],list[2],list[3])
      [result]
    end
  end
end