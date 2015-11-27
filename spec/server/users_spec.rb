require 'rspec'
require_relative '../../App/server/users'

describe Users do
  def initialize
    @users = Users.new
  end
  context 'The user should not be in the list of users' do
    it 'Should say the user does not exist when asked' do
      @users.should_not be_an_user_that_exists()
    end
  end
end