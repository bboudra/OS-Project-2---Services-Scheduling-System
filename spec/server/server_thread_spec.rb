require 'rspec'
require_relative '../../App/server/server_thread'

describe ServerThread do

  before(:each) do
    @server_thread = ServerThread.new
  end
  context 'The user does not exist in the user list' do
    it 'Should say the user does not exist when asked' do
      @server_thread.should_not be_an_user_that_exists()
    end
  end
end