class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :approach, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :value_serialized
      t.string :type

      t.timestamps
    end
  end
end
