require 'rails_helper'

RSpec.describe TextAnswer, type: :model do
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

  it "is not valid with longer value than question max_characters" do
    @question.update required: false, max_characters: 3
    @answer.value = "TEST"
    expect(@answer).to_not be_valid
  end

  it "is valid with longer or same lenght value like question max_characters" do
    @question.update required: false, max_characters: 4
    @answer.value = "TEST"
    expect(@answer).to be_valid
  end

  it "is valid with not empty value when question max_characters is 0" do
    @question.update required: false, max_characters: 0
    @answer.value = "TEST"
    expect(@answer).to be_valid
  end

  it "is valid if value is same after serialization" do
    example_text = "TEST"
    @answer.value = example_text
    expect(@answer.value).to eql example_text
  end

  it "is valid if allow_question_options? is true" do
    expect(TextAnswer.allow_question_options?).to eql true
  end

  it "is valid if require_question_options? is false" do
    expect(TextAnswer.require_question_options?).to eql false
  end
end
