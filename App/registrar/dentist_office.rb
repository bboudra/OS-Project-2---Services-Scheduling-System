module DentistOffice

  def get_office_port(office_name)
    @office_list['Office 1'] = 2001
    @office_list[office_name]
  end
end