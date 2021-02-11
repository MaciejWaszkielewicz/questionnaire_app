require 'rails_helper'

RSpec.describe Answer, type: :model do

  before(:each) do
    @survey = create :survey
    @section = create :section, survey: @survey
    @question = create :question, section: @section, value_type: "TextAnswer"
    @approach = create :approach, survey: @survey
    @answer = create :text_answer, approach: @approach, question: @question
  end

  it "is valid with valid attributes" do
    expect(@answer).to be_valid
  end

  it "is invalid with duplicated question for same approach" do
    answer = build :text_answer, approach: @approach, question: @question
    expect(answer).to_not be_valid
  end

  it "is invalid with wrong value type" do
    @answer.approach.survey = create :survey
    expect(@answer).to_not be_valid
  end

  it "is invalid with question that not belongs to approach survey" do
    @answer.question = create :question, value_type: "TextAnswer"
    expect(@answer).to_not be_valid
  end

  it "is invalid with diffrent type than question value_type" do
    @question.update value_type: "DateAnswer"
    expect(@answer).to_not be_valid
  end

  it "is invalid with nil or empty value if question required is true" do
    @question.update required: true
    @answer.value = nil
    expect(@answer).to_not be_valid
    @answer.value = ""
    expect(@answer).to_not be_valid
  end

  it "is valid with nil or empty value if question required is false" do
    @question.update required: false
    @answer.value = nil
    expect(@answer).to be_valid
    @answer.value = ""
    expect(@answer).to be_valid
  end
end
