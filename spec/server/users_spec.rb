require 'rspec'
require_relative '../../App/server/users'

describe Users do
  before(:each) do
    @users = Users.instance
  end

  context 'The user is not in the list of users' do
    it 'Should say the user does not exist when asked' do
      expect(@users).not_to be_user_that_exists(:user_that_does_not_exist)
    end

    it 'should be added tot he list of users' do
    end
  end
end