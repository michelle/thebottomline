class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def render_not_found
    render "404", :status => 404
  end
end
