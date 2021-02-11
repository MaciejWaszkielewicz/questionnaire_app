class Question < ApplicationRecord
  belongs_to :section
  has_many :options, -> { order(position: :asc) }
  has_many :answers

  acts_as_list scope: :section

  accepts_nested_attributes_for :options, allow_destroy: true

  validates :query, presence: true
  validates :value_type, inclusion: { in: proc { Answer.descendants.map{ |type| type.to_s } } }
  validates :max_characters, numericality: { greater_than_or_equal_to: 0 }
  validates :options, length: { minimum: 1, message: 'Minimum 1 option is required for selected value type' }, if: proc { |record| record.value_type.safe_constantize.require_question_options? }
  validates :options, length: { is: 0, message: 'Options are not allowed for selected value type' }, if: proc { |record| !record.value_type.safe_constantize.allow_question_options? }
end