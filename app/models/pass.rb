class Pass < ActiveRecord::Base

  belongs_to :user

  validates :name, :total_cost, :daily_cost, :duration_day, presence: true

  def days_to_break_even(total_cost, daily_cost)
    ((total_cost.to_f)/(daily_cost.to_f)).ceil
  end
  
end
