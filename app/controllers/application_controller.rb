class ApplicationController < ActionController::Base
  rescue_from ApiException, with: :render_api_exception

  private

  def render_api_exception(exception)
    render json: {message: exception.message, detail: exception.detail, code: exception.code}, status: :not_acceptable
  end
end
