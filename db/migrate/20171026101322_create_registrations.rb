class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :reg_identifier
      t.string :company_name

      t.timestamps null: false
    end
  end
end
