class Api::V1::MySevenController < ApplicationController
  before_action :authorize_request

  def example_endpoint
    render json: { message: 'This is an example endpoint' }
  end

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header

    begin
      decoded = JWT.decode(header, Rails.application.secrets.secret_key_base)
      @current_user = User.find(decoded[0]['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
