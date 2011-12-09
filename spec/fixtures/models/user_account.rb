class UserAccount
  attr_accessor :user, :roles

  def initialize user, options = {}
    @user = user
    @options = options
    @roles = options[:roles]
  end
  
  def role? name
    roles.include? name
  end
  
  def roles
    @roles ||= []
  end
end
