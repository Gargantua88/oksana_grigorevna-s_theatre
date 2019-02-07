class CreatePerfomances < ActiveRecord::Migration[5.2]
  def change
    create_table :perfomances do |t|
      t.string :title
      t.date :start_date
      t.date :finish_date

      t.timestamps
    end
  end
end
