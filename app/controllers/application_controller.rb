class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper :all
  layout :layout
  
  def layout
    if current_user
      "application"
    else
      "landing"
    end
  end
  
  def after_sign_in_path_for(resource_or_scope)
    flash[:notice] = 'Signed in successfully.'
    root_path
  end

  def after_send_path_for
    root_path
  end
  
  def is_login?
    unless current_user
      flash[:error] = "Please log in!"
      redirect_to root_path
    end
  end
end
