class SelectAnswer < Answer
  belongs_to :approach
  belongs_to :question
  has_and_belongs_to_many :options, join_table: :answers_options, class_name: "Option", foreign_key: :answer_id
  validate :option_exists?

  def self.allow_question_options?
    true
  end

  def self.require_question_options?
    true
  end

  def value
    self.options&.first
  end

  def value=(id)
    option = self.question.options.find_by(id: id)
    if option.nil?
      self.options = []
    else
      self.options = [option]
    end
  end

  def option_exists?
    unless self.question.options.find_by(id: self.value_serialized.to_i).present? || self.value_serialized.nil?
      errors.add(:value, "does not exists!")
    end
  end
end
