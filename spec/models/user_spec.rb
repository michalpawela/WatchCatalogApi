require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = create(:user)
  end
  it "is valid with valid attributes" do
    expect(@user).to be_valid
  end
  it "is not valid without a name" do
    @user.name=nil
    expect(@user).to_not be_valid
  end
  it "is not valid without a email" do
    @user.email=nil
    expect(@user).to_not be_valid
  end
  it "is not valid without a password" do
    @user.password=nil
    expect(@user).to_not be_valid
  end
  it "is not valid without a valid email" do
    @user.email = 'jeo42gmail.com'
    expect(@user).to_not be_valid
  end
  it "is not valid without a password with length 6 digits or more" do
    @user.password = '!@#$%'
    expect(@user).to_not be_valid
  end
end
