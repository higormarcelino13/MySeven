class AuthenticationController < ApplicationController
  def authenticate
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token(user.id)
      render json: { auth_token: token }
    else
      render json: { error: 'E-mail ou senha invalido!' }, status: :unauthorized
    end
  end

  private

  def encode_token(user_id)
    exp_time = if request.user_agent =~ /iPhone|Android/
                 3.minutes.from_now
               else
                 30.seconds.from_now
               end

    payload = { user_id: user_id, exp: exp_time.to_i }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
