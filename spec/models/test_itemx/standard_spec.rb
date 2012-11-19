require 'spec_helper'

describe TestItemx::Standard do
  it "name shouldn't be nil" do
    std = FactoryGirl.build(:standard, :name => nil)
    std.should_not be_valid
  end

  it "should reject duplicate name for active standard" do
    std1 = FactoryGirl.create(:standard, :name => 'test', :active => true)
    std2 = FactoryGirl.build(:standard, :name => 'TEst', :active => true)

    std2.should_not be_valid
  end

  it "should allow duplicate for non active standards" do
    std1 = FactoryGirl.create(:standard, :name => 'test', :active => false)
    std2 = FactoryGirl.build(:standard, :name => 'test', :active => false)

    std2.should be_valid
  end
end
