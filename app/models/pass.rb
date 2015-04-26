class Pass < ActiveRecord::Base

  belongs_to :user

  validates :name, :total_cost, :start_date, :duration_day, presence: true

  def days_to_break_even(total_cost, daily_cost)
    ((total_cost.to_f)/(daily_cost.to_f)).ceil
  end

  def days_left_to_attend(end_date)
    (end_date - Date.today).to_i
  end

  def attends_needed(break_even_days, attend_count)
    break_even_days - attend_count
  end

  def cost_per_visit(attend_count, total_cost)
    sprintf "%.2f", (total_cost/attend_count.to_f)
  end
  
end
