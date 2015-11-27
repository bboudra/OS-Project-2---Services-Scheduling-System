require 'singleton'
class Users
  include Singleton

  def initialize
    @user_hash = {}
  end

  ##
  #@param username, the name of the user
  def user_that_exists?(username)
    return @user_hash.has_key?(username)
  end

end