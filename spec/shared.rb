RSpec.shared_examples "valid object" do
  it "the subject should be valid" do
    subject.list = valid_partial_array
    expect(subject.valid?).to eq(true)
  end
end

RSpec.shared_examples "invalid object" do
  it "the subject should not be valid" do
    subject.list = invalid_partial_array
    expect(subject.valid?).to eq(false)
  end

  it "the subject should have an error" do
    subject.list = invalid_partial_array
    subject.valid?
    expect(subject.errors.messages).to eq({:list=>["not valid"]})
  end
end
