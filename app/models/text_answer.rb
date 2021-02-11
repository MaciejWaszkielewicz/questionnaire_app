class TextAnswer < Answer

  validates :value, length: { maximum: proc { |record| record.question.max_characters } },
    if: proc { |record| record.question.max_characters&.positive? }

  def self.allow_question_options?
    true
  end

  def value
    self.value_serialized
  end

  def value=(val)
    self.value_serialized = val
  end
end
