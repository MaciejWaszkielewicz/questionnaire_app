require 'rails_helper'

RSpec.describe SelectAnswer, type: :model do
  before(:each) do
    @survey = create :survey
    @section = create :section, survey: @survey
    @question = build :question, section: @section, value_type: "SelectAnswer"
    @option = @question.options.build answer_text: "test"
    @question.save
    @approach = create :approach, survey: @survey
    @answer = create :select_answer, approach: @approach, question: @question
  end

  it "is valid if value is same after serialization" do
    @answer.value = @option.id
    expect(@answer.value).to eql @option
  end

  it "is not asignin option if option belongs to diffrent question" do
    question = build :question, section: @section, value_type: "SelectAnswer"
    option = question.options.build answer_text: "test"
    question.save
    @answer.value = option.id
    expect(@answer.value).to_not eql option
  end

  it "is valid if allow_question_options? is true" do
    expect(SelectAnswer.allow_question_options?).to eql true
  end

  it "is valid if require_question_options? is true" do
    expect(SelectAnswer.require_question_options?).to eql true
  end
end
