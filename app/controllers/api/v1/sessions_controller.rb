class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: token_json(user)
    else
      render json: {error: "Wrong Log-in"}
    end
  end
end

  # skip_before_action :authenticate
  #
  # def create
  #   user = User.find_by(email: auth_params[:email])
  #   if user.authenticate(auth_params[:password])
  #     jwt = Auth.issue({user: user.id})
  #     render json: {jwt: jwt}
  #   else
  #   end
  # end
  #
  # private
  #   def auth_params
  #     params.require(:auth).permit(:email, :password)
  #   end


# --------------------------------------------------
# LOGIN REQUEST FROM FRONTEND

# fetch("http://localhost:3000/api/v1/login", { method:"POST",
# headers: {"Content-Type": "application/json"},
# body: JSON.stringify({
#     email: "f@g.com",
#     password: "win"}
# ) }).then(res => res.json()).then(console.log)
