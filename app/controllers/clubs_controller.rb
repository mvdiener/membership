class ClubsController < ApplicationController

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    @club.user = current_user
    if @club.save
      redirect_to(user_path(current_user), method: "GET")
    else
      @errors = @club.errors.full_messages
      render 'new'
    end
  end

  def show
  end

  private

    def club_params
      params.require(:club).permit(:name, :type, :cost)
    end


end