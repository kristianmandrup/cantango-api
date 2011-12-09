module CurrentUsers
  def current_user
    @current_user ||= ::User.new 'stan', 'stan@mail.ru', :role => 'user'
  end

  def current_guest
    @current_guest ||= ::User.new 'guest', 'guest@mail.ru', :role => 'guest'
  end

  def current_admin
    @current_admin ||= ::Admin.new 'admin', 'admin@mail.ru', :role => 'admin'
  end
end

