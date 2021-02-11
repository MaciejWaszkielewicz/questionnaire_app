class Section < ApplicationRecord
  belongs_to :survey
  has_many :questions, -> { order(position: :asc) }

  acts_as_list scope: :survey

  def next
    survey.sections.select{ |section| section.position > position }&.first
  end

  def previous
    survey.sections.select{ |section| section.position < position }&.last
  end
end
