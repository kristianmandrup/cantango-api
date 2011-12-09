class Project #< ActiveRecord::Base
  attr_accessor :user
  
  def create user
    @user = user
  end
  
  def owner
    user
  end
end
