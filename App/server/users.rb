require 'singleton'
class Users
  include Singleton
  def initialize
    @user_hash = {}
  end

  def user_that_exists?

  end
end