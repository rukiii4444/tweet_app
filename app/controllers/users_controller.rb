class UsersController < ApplicationController
  # before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  # before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  # before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name], 
      email: params[:email],
      image_name: "default_user.jpg",
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Done :)"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "Done :)"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end 
  end

  def login_form
  end

  def login
    @user = User.find_by(
      email: params[:email], 
      password: params[:password]
    )
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "Success to login :)"
      redirect_to("/posts/index")
    else
      @error_message = "Wrong email or passwoed :("
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end  
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Success to logout :)"
    redirect_to("/login")
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "You are not authorized :("
      redirect_to("/posts/index")
    end
  end
end
