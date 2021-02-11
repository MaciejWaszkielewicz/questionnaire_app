class Approach < ApplicationRecord
  belongs_to :survey
  has_many :answers, dependent: :destroy
  validate :survey_have_any_question

  accepts_nested_attributes_for :answers

  private

  def survey_have_any_question
    errors.add :survey, message: "don't have any question!" unless survey.questions.any?
  end
end
