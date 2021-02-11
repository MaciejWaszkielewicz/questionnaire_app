require 'rails_helper'

RSpec.describe Option, type: :model do
  subject { create( :option, question: create( :question, value_type: "TextAnswer" ) ) }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a answer text" do
    subject.answer_text = nil
    expect(subject).to_not be_valid
  end

  it "is destroyed when were not used in answers" do
    expect(subject.destroy.destroyed?).to eql true
  end

  it "is not destroyed when were used in answers" do
    question = subject.question
    question.update value_type: "SelectAnswer"
    create :select_answer, value: subject.id, question: question, approach: create(:approach, survey: question.section.survey)

    expect(subject.destroy.destroyed?).to eql false
  end
end
