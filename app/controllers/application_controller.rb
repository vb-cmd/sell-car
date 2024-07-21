class ApplicationController < ActionController::Base
  def encode_token(user)
    JWT.encode({ user_id: user.id }, ENV['JWT_KEY'])
  end

  def decoded_token(token)
    JWT.decode(token, ENV['JWT_KEY'])
  rescue JWT::DecodeError
    nil
  end

  def token_from_bearer
    auth_header = request.headers['Authorization']
    return unless auth_header

    auth_header.split(' ')[1]
  end

  def token_from_cookie
    cookie_token = request.cookies['jwt']

    return unless cookie_token

    cookie_token
  end

  def current_user
    token = token_from_bearer || token_from_cookie
    
    return unless token

    data = decoded_token(token)

    return unless data

    user_id = data[0]['user_id']
    User.find(user_id)
  end

  def authorized_render_json
    return if !!current_user

    render json: { message: 'Please log in or register' }, status: :unauthorized
  end

  def authorized_redirect
    return if !!current_user

    redirect_to root_path, alert: 'Please log in or register'
  end
end
