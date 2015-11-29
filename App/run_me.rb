require './registrar_driver'
require './client_driver'
puts "i atleast reached here?"
Thread.new do
  registrar_driver = RegistrarDriver.new
  registrar_driver.run
end
Thread.new do
  server_driver = ServerDriver.new
  server_driver
end
client_driver = ClientDriver.new
client_driver.start_run
