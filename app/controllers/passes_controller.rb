class PassesController < ApplicationController

  def new
    @pass = Pass.new
  end

  def create
    @pass = Pass.new(pass_params)
    @pass.user = current_user
    @pass.break_even_day = @pass.days_to_break_even(@pass.total_cost, @pass.daily_cost) if @pass.daily_cost
    @pass.end_date = @pass.start_date + @pass.duration_day
    if @pass.save
      redirect_to(user_path(current_user), method: "GET")
    else
      @errors = @pass.errors.full_messages
      render 'new'
    end
  end

  def show
    @pass = Pass.find(params[:id].to_i)
    @days_left = @pass.days_left_to_attend(@pass.end_date)
    if @pass.break_even_day
      @attends_needed = @pass.attends_needed(@pass.break_even_day, @pass.attended_count)
      savings = @pass.savings(@pass.attended_count, @pass.daily_cost, @pass.total_cost)
      if savings.to_f > 0
        @savings = "saved $#{savings}"
      else
        @savings = "lost $#{sprintf "%.2f", savings.to_f.abs}"
      end
    end
    @cost = @pass.cost_per_visit(@pass.attended_count, @pass.total_cost) if @pass.attended_count > 0
  end

  def increase
    @pass = Pass.find(params[:id].to_i)
    @pass.attended_count += 1
    @pass.save
    redirect_to pass_path(params[:id].to_i)
  end

  def destroy
    @pass = Pass.find(params[:id].to_i)
    @pass.delete
    redirect_to(user_path(current_user), method: "GET")
  end

  private

    def pass_params
      params.require(:pass).permit(:name, :total_cost, :start_date, :daily_cost, :duration_day)
    end

end