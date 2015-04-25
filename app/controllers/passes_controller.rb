class PassesController < ApplicationController

  def new
    @pass = Pass.new
  end

  def create
    @pass = Pass.new(pass_params)
    @pass.user = current_user
    @pass.break_even_day = @pass.days_to_break_even(@pass.total_cost, @pass.daily_cost)
    if @pass.save
      redirect_to(user_path(current_user), method: "GET")
    else
      @errors = @pass.errors.full_messages
      render 'new'
    end
  end

  def show
  end

  private

    def pass_params
      params.require(:pass).permit(:name, :total_cost, :daily_cost, :duration_day)
    end

end