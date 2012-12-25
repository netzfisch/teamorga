class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]
  before_filter :correct_user, :except => [:index, :show, :new, :create]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
      redirect_to edit_user_path(@user), notice: 'User was successfully created / Signed up!'
    else
      render action: "new"
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      session[:user_id] = nil
      redirect_to root_url, notice: 'User was successfully deleted / Signed out!'
    else
      render action: "new"
    end
  end

end

