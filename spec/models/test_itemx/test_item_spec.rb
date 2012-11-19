require 'spec_helper'

describe TestItemx::TestItem do
  it "should have a name" do
    t = FactoryGirl.build(:test_item, :name => "a good name")
    t.should be_valid
  end

  it "should reject nil name" do
    t = FactoryGirl.build(:test_item, :name => nil)
    t.should_not be_valid
  end

  it "should be reject duplicate name" do
    t1 = FactoryGirl.create(:test_item, :name => "test name", :active => true)
    t2 = FactoryGirl.build(:test_item, :name => "test Name", :active => true)
    t2.should_not be_valid
  end

  it "should be reject duplicate name for non active test items" do
    t1 = FactoryGirl.create(:test_item, :name => "test name", :active => false)
    t2 = FactoryGirl.build(:test_item, :name => "test Name", :active => false)
    t2.should be_valid
  end

  it "should be OK to take a duplicate name for different active status" do
    t1 = FactoryGirl.create(:test_item, :name => "test name", :active => false)
    t2 = FactoryGirl.build(:test_item, :name => "test Name", :active => true)
    t2.should be_valid
  end

  it "should have >0 rate" do
    t = FactoryGirl.build(:test_item, :rate => 600.00)
    t.should be_valid
  end

  it "should have >0 rate" do
    t = FactoryGirl.build(:test_item, :rate => 0.00)
    t.should_not be_valid
  end

  it "should have description" do
    t = FactoryGirl.build(:test_item, :description => "test item description")
    t.should be_valid
  end

  it "should reject nil description" do
    t = FactoryGirl.build(:test_item, :description => nil)
    t.should_not be_valid
  end

  it "should have standard id" do
    t = FactoryGirl.build(:test_item, :standard_id => 2)
    t.should be_valid
  end

  it "should reject nil standard ID" do
    t = FactoryGirl.build(:test_item, :standard_id => nil)
    t.should_not be_valid
  end
end
