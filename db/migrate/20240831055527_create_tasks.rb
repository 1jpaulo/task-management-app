class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.string :priority, null: false
      t.timestamp :due_date, null: false
      t.boolean :completed, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tasks, :priority
    add_index :tasks, :due_date
  end
end
