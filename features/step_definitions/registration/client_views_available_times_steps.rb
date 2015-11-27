require_relative '../../../App/client/client'

Given(/^I am a client$/) do
  @client = Client.new
end

Given(/^The available times for the date '(\d+)\/(\d+)\/(\d+)' are from '(\d+)' to '(\d+)'$/) do |arg1, arg2, arg3, arg4, arg5|
  start_time = @client.convert_time_to_military_float(arg4)
  end_time = @client.convert_time_to_military_float(arg4)
  @client.get_date_doctor_appt_length_from_user("#{arg1}/#{arg2}/#{arg3}",arg4,arg5)
  @client.make_appointment("#{arg1}/#{arg2}/#{arg3}",6.0,start_time- 6.0)
  @client.make_appointment("#{arg1}/#{arg2}/#{arg3}",2.0,20.0-end_time)
end


When(/^I ask to view the available times for the date '(\d+)\/(\d+)\/(\d+)' for an appoint length of '(\d+)' hour$/) do |arg1, arg2, arg3, arg4|
  pending # Write code here that turns the phrase above into concrete actions
  expect(@client.get_available_times).to eq()
end


Then(/^I should receive the list of available times for that day$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end