class CreateTrainees < ActiveRecord::Migration[5.0]
  def change
    create_table :trainees do |t|
      t.string :name
      t.string :gender
      t.integer :age
      t.integer :distance
      t.string :job_category

      t.timestamps
    end
  end
end
