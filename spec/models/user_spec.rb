require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Joe', email: 'jeo42@gmail.com', password: 'password') }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a name" do
    subject.name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a email" do
    subject.email=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a password" do
    subject.password=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a valid email" do
    subject.email = 'jeo42gmail.com'
    expect(subject).to_not be_valid
  end
  it "is not valid without a password with length 6 digits or more" do
    subject.password = '!@#$%'
    expect(subject).to_not be_valid
  end
end
