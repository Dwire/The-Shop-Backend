# class Api::V1::SessionsController < ApplicationController
#   def create
#     user = User.find_by(email: params[:email])
#     if user && user.authenticate(params[:password])
#       render json: token_json(user)
#     else
#       render json: {error: "Wrong Log-in"}
#     end
#   end
# end



class Api::V1::AuthenticationsController < ApplicationController
  skip_before_action :authorized, only: [:create, :show]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: {id: user.id, name: user.name, email: user.email, guru: user.guru, project: user.project, token: generate_token({id: user.id})}
    else
      render({json: {error: 'User is invalid'}, status: 401})
    end
  end

  # def show
  #   if current_user
  #     render json: {
  #       id: current_user.id,
  #       name: current_user.name,
  #       email: current_user.email
  #     }
  #   else
  #     render json: {error: 'Invalid token'}, status: 401
  #   end
  # end

  def show
  # token = request.headers['Authorization']
  # user = User.find_by(id: token)
  if logged_in?
    render json: { id: current_user.id, name: current_user.name, email: current_user.email }
  else
    render json: {error: 'No user could be found'}, status: 401
  end
end


end
# --------------------------------------------------
# LOGIN REQUEST FROM FRONTEND

# fetch("http://localhost:3000/api/v1/login", { method:"POST",
# headers: {"Content-Type": "application/json"},
# body: JSON.stringify({
#     email: "f@g.com",
#     password: "win"}
# ) }).then(res => res.json()).then(console.log)
