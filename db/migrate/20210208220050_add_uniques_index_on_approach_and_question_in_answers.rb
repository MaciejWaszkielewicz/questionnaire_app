class AddUniquesIndexOnApproachAndQuestionInAnswers < ActiveRecord::Migration[6.1]
  def change
    add_index :answers, [:approach_id, :question_id], unique: true
  end
end
