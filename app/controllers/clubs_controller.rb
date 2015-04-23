class ClubsController < ApplicationController

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    @club.user = current_user
    @club.break_even_day = @club.days_to_break_even(@club.total_cost, @club.daily_cost)
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
      params.require(:club).permit(:name, :total_cost, :daily_cost, :duration_day)
    end


end