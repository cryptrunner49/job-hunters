class HuntersController < ApplicationController
  # Skip any authentication filters so that new hunters can access the sign-up page.
  skip_before_action :require_authentication, only: %i[new create]
  # before_action :correct_hunter, only: [:edit, :update]
  # before_action :admin_hunter, only: :destroy

  def new
    @hunter = Hunter.new
  end

  def create
    @hunter = Hunter.new(hunter_params)
    if @hunter.save
      session[:hunter_id] = @hunter.id  # Log in the hunter after successful registration.
      redirect_to root_path, notice: "Account created successfully!"
    else
      flash.now[:alert] = @hunter.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @hunter.soft_delete
    redirect_to root_path, notice: "Account was successfully deleted."
  end

  private

  def hunter_params
    # Permit the necessary fields including an optional profile picture.
    params.require(:hunter).permit(:name, :email_address, :password, :password_confirmation, :profile_picture)
  end
end
