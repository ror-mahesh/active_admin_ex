class CreateCoachParAvails < ActiveRecord::Migration[7.0]
  def change
    create_table :coach_par_avails do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :account_id

      t.timestamps
    end
  end
end
