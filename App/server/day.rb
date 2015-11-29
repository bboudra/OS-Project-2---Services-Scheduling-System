class Day
  attr_reader :times
  attr_reader :date
  BEGINNING_OF_DAY = 8 * 4 #8 AM military time * 4 15 minute time slots in an hour
  END_OF_DAY = (20 * 4) - 1 #8 PM military time * 4 15 minute time slots in an hour, -1 because time slot is 7:45 PM to 8:00 PM
  def initialize(date)
    @date =
        @times = {}
    BEGINNING_OF_DAY.upto(END_OF_DAY) do |x|
      @times[x] = true
    end
  end

  def get_free_times(appointment_length)
    free_times = []
    BEGINNING_OF_DAY.upto(END_OF_DAY) do |current_time_slot|
      current_time_slot
      free = self.is_free_time_slot(current_time_slot, appointment_length)
      if free
        presentable_time = convert_to_presentable_time(current_time_slot)
        free_times.push(presentable_time)
      end
    end
    return free_times
  end

  def is_free_time_slot(current_time_slot, appointment_length)
    appointment_time_slots = (appointment_length / 0.25).to_i
    current_time_slot.upto(current_time_slot + (appointment_time_slots)) do |x|
      if @times.length + 32 < x
        return false
      elsif @times[x] == false
        return false
      end
    end
    return true
  end

  def convert_to_presentable_time(time)
    hours = time / 4
    minutes = (((time.to_f / 4.0) - (time / 4).to_f) * 60).round
    presentable_time = "#{hours}:#{minutes}"
    return presentable_time
  end
end

