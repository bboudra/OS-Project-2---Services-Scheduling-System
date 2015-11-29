class Office
  def initialize
    @office_list = {}
    @office_list["Office 1"] = 2001
  end

  def get_office_port(office_name)
    return @office_list[office_name]
  end
end