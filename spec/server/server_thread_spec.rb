require 'rspec'
require_relative '../../App/server/server_thread'

describe ServerThread do

  before(:each) do
    @server_thread = ServerThread.new
  end
end