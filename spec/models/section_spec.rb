require 'rails_helper'

RSpec.describe Section, type: :model do
  subject { build(:section) }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is valid without a title" do
    subject.title = nil
    expect(subject).to be_valid
  end
end
