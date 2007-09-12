require File.dirname(__FILE__) + '/../spec_helper'

describe "A User" do
  include ActiveRecordMatchers

  before(:each) do
   @user = User.new :login => 'quentin', :password => 'blah', :password_confirmation => 'blah', :email => 'quentin@example.com'
  end

  it "should have valid associations" do
     @user.save!
     @user.should have_valid_associations
  end

  it "should protect against updates to secure attributes" do
    @user.save
    lambda{ 
      @user.update_attributes(:created_at => 3)
    }.should_not change(@user, :created_at)
  end
  
end

