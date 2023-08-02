class CreateCoachParTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :coach_par_times do |t|
      t.string :from
      t.string :to
      t.boolean :booked_slot
      t.string :sno
      t.integer :coach_par_avail_id
      t.date :dates

      t.timestamps
    end
  end
end
