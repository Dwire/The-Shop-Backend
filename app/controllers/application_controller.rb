class ApplicationController < ActionController::API

  # First 3 create tokens
  def jwt_password
    ENV["JWT_PASSWORD"]
  end

  def generate_token(user)
    JWT.encode({"user_id": user.id}, jwt_password, 'HS256')
  end

  def token_json(user)
    {
      email: user.email,
      user_id: user.id,
      token: generate_token(user)
    }
  end

 #Second 3 check tokens
  def try_decode_token
    token = request.headers["Authorization"]
    begin
      decoded = JWT.decode(token, jwt_password, true, {algorithm: 'HS256'})
    rescue
      puts "verification error"
      return nil
    end
  end

  def valid_token?
    !!try_decode_token
  end

  def current_user
    decoded = try_decode_token
    unless decoded && decoded[0] && decod["user_id"]
      return nil
    end

    User.find(decoded[0]["user_id"])
  end

end

# before_action :authenticate
#
# def logged_in?
#   !!current_user
# end
#
# def current_user
#   if auth_present?
#     user = User.find(auth["user"])
#     if user
#       @current_user ||= user
#     end
#   end
# end
#
# def authenticate
#   render json: {error: "unauthorized"}, status: 401
#     unless logged_in?
# end
#
# private
#   def token
#     request.env["HTTP_AUTHORIZATION"].scan(/Bearer
#       (.*)$/).flatten.last
#   end
#   def auth
#     Auth.decode(token)
#   end
#   def auth_present?
#     !!request.env.fetch("HTTP_AUTHORIZATION",
#       "").scan(/Bearer/).flatten.first
#   end
