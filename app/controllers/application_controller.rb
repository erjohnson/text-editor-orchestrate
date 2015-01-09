class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  
  def app
    @app ||= Orchestrate::Application.new(ENV['ORCHESTRATE_API_KEY'])
  end
  helper_method :app

  def client
    @client ||= Orchestrate::Client.new(ENV['ORCHESTRATE_API_KEY'])
  end
  helper_method :client
  
end
