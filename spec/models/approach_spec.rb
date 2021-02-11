require 'rails_helper'

RSpec.describe Approach, type: :model do
  before(:each) do
    @survey = create :survey
    @section = create :section, survey: @survey
    @question = create :question, section: @section, value_type: "TextAnswer"
    subject { build :approach }
    subject.survey = @survey
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid with survey that doesn't have questions" do
    subject.survey = build :survey
    expect(subject).to_not be_valid
  end
end
