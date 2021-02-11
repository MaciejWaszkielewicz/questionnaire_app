class AddSurveyToSections < ActiveRecord::Migration[6.1]
  def change
    add_reference :sections, :survey, null: false, foreign_key: true
  end
end
