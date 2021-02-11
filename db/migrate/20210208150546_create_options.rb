class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.string :answer_text
      t.string :position
      t.references :question, null: false, foreign_key: true


      t.timestamps
    end
  end
end
