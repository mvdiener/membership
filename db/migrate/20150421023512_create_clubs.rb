class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.integer :user_id
      t.string :name
      t.float :total_cost
      t.float :daily_cost
      t.integer :break_even_day
      t.date :start_date
      t.string :duration_type
      t.integer :duration_day

      t.timestamps
    end
  end
end
