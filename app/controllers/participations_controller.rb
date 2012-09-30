class ParticipationsController < ApplicationController
  before_filter :correct_user

  # GET /participation/1/edit
  def edit
    @user = User.find(params[:id])
  end
end
