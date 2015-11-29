class Utilities
  def prepend_zeros(some_string, length)
    some_string = "0#{some_string}" until some_string.length == length
  end

end