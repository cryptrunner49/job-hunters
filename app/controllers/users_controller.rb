class UsersController < ApplicationController
  # Skip any authentication filters so that new users can access the sign-up page.
  skip_before_action :require_authentication, only: %i[new create]
  # before_action :correct_user, only: [:edit, :update]
  # before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id  # Log in the user after successful registration.
      redirect_to root_path, notice: "Account created successfully!"
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    # Permit the necessary fields including an optional profile picture.
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :profile_picture)
  end
end
