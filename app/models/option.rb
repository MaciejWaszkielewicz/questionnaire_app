class Option < ApplicationRecord
  has_and_belongs_to_many :answers, join_table: :answers_options, class_name: "Answer"
  belongs_to :question, optional: true

  acts_as_list

  validates :answer_text, presence: true

  def destroy
    if answers.any?
      errors.add(:option, "with existing answers cannot be deleted!")
      return self
    end
    super
  end
end
