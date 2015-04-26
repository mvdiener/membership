class CreatePasses < ActiveRecord::Migration
  def change
    create_table :passes do |t|
      t.integer :user_id
      t.string :name
      t.float :total_cost
      t.float :daily_cost
      t.integer :break_even_day
      t.date :start_date
      t.date :end_date
      t.integer :duration_day
      t.integer :attended_count, default: 0

      t.timestamps
    end
  end
end
