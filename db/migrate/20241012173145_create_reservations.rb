class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.datetime :check_in
      t.datetime :check_out
      t.integer :number
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
