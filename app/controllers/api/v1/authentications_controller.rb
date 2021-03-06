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
  skip_before_action :authorized, only: [:login, :create]

  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: {id: user.id, name: user.name, email: user.email, guru: user.guru, project: user.project, longitude: user.longitude, latitude: user.latitude, token: generate_token({id: user.id})}
    else
      render({json: {error: 'User is invalid'}, status: 401})
    end
  end

  def create
    user = User.create(name: params[:name], email: params[:email], password: params[:password], latitude: params[:latitude], longitude: params[:longitude])

    if user && user.authenticate(params[:password])
      render json: {id: user.id, name: user.name, email: user.email, guru: user.guru, project: user.project, longitude: user.longitude, latitude: user.latitude, token: generate_token({id: user.id})}
    else
      render({json: {error: 'Sign Up Failed Personal Message'}, status: 401})
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
    render json: { id: current_user.id, name: current_user.name, email: current_user.email, guru: current_user.guru, project: current_user.project, longitude: current_user.longitude, latitude: current_user.latitude }
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
