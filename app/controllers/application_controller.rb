class ApplicationController < ActionController::API
  before_action :authorized


  def jwt_password
    ENV["JWT_PASSWORD"]
  end

  def generate_token(payload)
    JWT.encode(payload, jwt_password, 'HS256')
  end

   def current_user
     @user ||= User.find_by(id: user_id)
   end

   def user_id
     decode_token.first['id']
   end

 
  def decode_token
    token = request.headers["Authorization"]
    begin
      decoded = JWT.decode(token, jwt_password, true, {algorithm: 'HS256'})
    rescue JWT::DecodeError
      puts "verification error"
      [{}]
    end
  end

   def authorized
     render json: {message: "Not welcome" }, status: 401 unless logged_in?
   end

  def logged_in?
    !!current_user
  end
end

# ------------------------------- Alex Solution from https://gist.github.com/alexgriff/414a05a0b6908145f050888e073df7ff

# class ApplicationController < ActionController::API
#
#   before_action :authorized
#  # this will run before every single action gets called, make sure you skip_before_action in the appropriate places
#
#  def issue_token(payload)
#    JWT.encode(payload, ENV['secret'], 'HS256')
#    # your secret should be in another file that is .gitignore'd, use a gem like 'figaro' to manage
#  end
#
#  def current_user
#    @user ||= User.find_by(id: user_id)
#  end
#
#  def user_id
#    decoded_token.first['id']
#  end
#
#  def decoded_token
#    begin
#       JWT.decode(request.headers['Authorization'], ENV['secret'], true, { :algorithm => 'HS256' })
#     rescue JWT::DecodeError
#      [{}]
#     end
#  end
#
#  def authorized
#    render json: {message: "Not welcome" }, status: 401 unless logged_in?
#  end
#
#  def logged_in?
#    !!current_user
#  end
# end

# -------------------------- Manual Original Working Solution -----------------------------------------------
# class ApplicationController < ActionController::API
#
#   # First 3 create tokens
#   def jwt_password
#     ENV["JWT_PASSWORD"]
#   end
#
#   def generate_token(user)
#     JWT.encode({"user_id": user.id}, jwt_password, 'HS256')
#   end
#
#   def token_json(user)
#     {
#       email: user.email,
#       user_id: user.id,
#       token: generate_token(user)
#     }
#   end
#
#  #Second 3 check tokens
#   def try_decode_token
#     token = request.headers["Authorization"]
#     begin
#       decoded = JWT.decode(token, jwt_password, true, {algorithm: 'HS256'})
#     rescue
#       puts "verification error"
#       return nil
#     end
#   end
#
#   def valid_token?
#     !!try_decode_token
#   end
#
#   def current_user
#     decoded = try_decode_token
#     unless decoded && decoded[0] && decod["user_id"]
#       return nil
#     end
#
#     User.find(decoded[0]["user_id"])
#   end
#
# end
