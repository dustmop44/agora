class CreateStalls < ActiveRecord::Migration[5.1]
  def change
    create_table :stalls do |t|
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :stalls, [:user_id, :created_at]
  end
end
