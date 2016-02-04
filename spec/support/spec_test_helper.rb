module SpecTestHelper
  # Below method for future use. Admin user role not implemented yet
  def login_admin
    login(:admin)
  end

  def login(user)
    user = User.where(:login => user.to_s).first if user.is_a?(Symbol)
    request.session[:user_id] = user.id
  end

  def current_user
    User.find(request.session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
