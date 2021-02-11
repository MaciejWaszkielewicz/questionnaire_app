require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { create :question, value_type: "TextAnswer" }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a query" do
    subject.query = nil
    expect(subject).to_not be_valid
  end

  it "is valid if have no options and value_type.require_question_options? is false" do
    expect(subject.value_type.safe_constantize.require_question_options?).to eql false
    expect(subject).to be_valid
  end

  it "is valid if have options and value_type.require_question_options? is true" do
    subject.value_type = "SelectAnswer"
    expect(subject.value_type.safe_constantize.require_question_options?).to eql true
    create :option, question: subject
    expect(subject).to be_valid
  end

  it "is invalid if have no options and value_type.require_question_options? is true" do
    subject.value_type = "SelectAnswer"
    expect(subject.value_type.safe_constantize.require_question_options?).to eql true
    expect(subject).to_not be_valid
  end

  it "is valid if have no options and value_type.allow_question_options? is false" do
    subject.value_type = "DateAnswer"
    expect(subject.value_type.safe_constantize.allow_question_options?).to eql false
    expect(subject).to be_valid
  end

  it "is valid if have options and value_type.allow_question_options? is true" do
    expect(subject.value_type.safe_constantize.allow_question_options?).to eql true
    create :option, question: subject
    expect(subject).to be_valid
  end

  it "is invalid if have options and value_type.allow_question_options? is false" do
    subject.value_type = "DateAnswer"
    expect(subject.value_type.safe_constantize.allow_question_options?).to eql false
    create :option, question: subject
    expect(subject).to_not be_valid
  end

end
