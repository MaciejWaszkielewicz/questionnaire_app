class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :query
      t.string :value_type, null: false
      t.boolean :required, null: false, default: false
      t.integer :max_characters, null: false, default: 0
      t.integer :position
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
