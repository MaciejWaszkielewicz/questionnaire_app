class Survey < ApplicationRecord
  has_many :sections, -> { order(position: :asc) }
  has_many :questions, -> { reorder('sections.position ASC', 'questions.position ASC') },
    through: :sections
  has_many :approaches
  validates :title, presence: true
end
