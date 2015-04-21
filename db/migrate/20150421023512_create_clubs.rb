class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.integer :user_id
      t.string :name
      t.string :type
      t.integer :cost

      t.timestamps
    end
  end
end
