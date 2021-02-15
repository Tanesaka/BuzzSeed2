class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


# 例外処理
unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Exception, with: :render_500
end

def render_404
  render template: 'errors/404', status: 404, layout: 'application', content_type: 'text/html'
end

def render_500
  render template: 'errors/500', status: 500, layout: 'application', content_type: 'text/html'
end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :unique_code])
  end
end
