class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session    #Can't verify CSRF token authenticity.

end