require 'rails_helper'

RSpec.describe DateAnswer, type: :model do
  before(:each) do
    @survey = create :survey
    @section = create :section, survey: @survey
    @question = create :question, section: @section, value_type: "DateAnswer"
    @approach = create :approach, survey: @survey
    @answer = create :date_answer, approach: @approach, question: @question
  end

  it "is valid if value is same after serialization" do
    example_date = Date.today
    @answer.value = example_date
    expect(@answer.value).to eql example_date
  end

  it "is valid if allow_question_options? is false" do
    expect(DateAnswer.allow_question_options?).to eql false
  end

  it "is valid if require_question_options? is false" do
    expect(DateAnswer.require_question_options?).to eql false
  end
end
