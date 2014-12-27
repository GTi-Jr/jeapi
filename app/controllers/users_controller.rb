class UsersController < ApplicationController  
  before_filter :validate_token
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render :json => @users.to_json(:include => :junior_enterprise)
  end

  def find_junior_enterprise
    @user = User.find(params[:id])

    render :json => @user.to_json(:include => :junior_enterprise)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    render :json => @user.to_json(:include => { :junior_enterprise => { :include => [:messages, :members] }})
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      if @user.function == "user"     
        UserNotifier.send_signup_email(@user).deliver
      elsif @user.function == "federation"
        UserNotifier.send_signup_email_federation(@user).deliver
      end
        
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end

  def log_in    
    user = User.find_by password: params[:password], email: params[:email]

    if user != nil
      render json: user
    else
      head :no_content
    end
  end

  def recover_email
    user = User.find_by email: params[:email]
    if user != nil
      user.password = SecureRandom.urlsafe_base64(6,false)
      user.save
      UserNotifier.send_recover_email(user).deliver   
      render json: user, status: :ok
    else
      render json: user, status: :no_content
    end
  end

  private
    
    def user_params
      params.permit(:password, :email, :function, :state)
    end
end
