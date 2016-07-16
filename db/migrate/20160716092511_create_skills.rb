class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.string :description
      t.string :category

      t.timestamps
    end

    create_table :skills_trainees, id: false do |t|
      t.belongs_to :skill, index: true
      t.belongs_to :trainee, index: true
    end
  end
end
