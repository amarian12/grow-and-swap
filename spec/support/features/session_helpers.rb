require 'rails_helper'

module Features
  module SessionHelpers
    # background do
    #   @user = create(:user)
    #   User.find @user.id
    # end

    def sign_up_with(email, password)
      visit '/sessions/new'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign up'
    end

    def log_in_with(user)
      visit '/sessions/new'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    # The following methods can be used as helper methods for future tests

    # def is_logged_in?
    #   !session[:user_id].nil?
    # end

    # def log_in_as(user, options = {})
    #   password    = options[:password]    || 'password'
    #   remember_me = options[:remember_me] || '1'
    #   if feature_test?
    #     post login_path, session: { email:        user.email,
    #                                 password:     password,
    #                                 remember_me:  remember_me }
    #   else
    #     session[:user_id] = user.id
    #   end
    # end

    # private

    # def feature_test?
    #   method_defined?(post_via_redirect)
    # end
  end
end
