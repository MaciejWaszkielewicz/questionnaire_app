class Answer < ApplicationRecord
  # Force to load models - required in development mode
  # Without this #descendants return [] if models was not loaded
  require_dependency "text_answer"
  require_dependency "date_answer"
  require_dependency "select_answer"

  belongs_to :approach
  belongs_to :question

  validates :approach_id, uniqueness: { scope: :question_id }
  validates :question_id, inclusion: { in: proc { |record| record.approach.survey.questions.select(:id).pluck(:id) } }
  validates :type, inclusion: { in: proc { |record| [record.question.value_type] } }
  validates :value, presence: true, if: proc { |record| record.question.required? }

  def value=
    raise NotImplementedError
  end

  def value
    raise NotImplementedError
  end

  def self.allow_question_options?
    if self.require_question_options?
      raise NotImplementedError
    end
    false
  end

  def self.require_question_options?
    false
  end
end
