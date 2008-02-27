require File.dirname(__FILE__) + '/../spec_helper'

describe BusinessesController do
  describe "route generation" do

    it "should map { :controller => 'businesses', :action => 'index' } to /businesses" do
      route_for(:controller => "businesses", :action => "index").should == "/businesses"
    end
  
    it "should map { :controller => 'businesses', :action => 'new' } to /businesses/new" do
      route_for(:controller => "businesses", :action => "new").should == "/businesses/new"
    end
  
    it "should map { :controller => 'businesses', :action => 'show', :id => 1 } to /businesses/1" do
      route_for(:controller => "businesses", :action => "show", :id => 1).should == "/businesses/1"
    end
  
    it "should map { :controller => 'businesses', :action => 'edit', :id => 1 } to /businesses/1/edit" do
      route_for(:controller => "businesses", :action => "edit", :id => 1).should == "/businesses/1/edit"
    end
  
    it "should map { :controller => 'businesses', :action => 'update', :id => 1} to /businesses/1" do
      route_for(:controller => "businesses", :action => "update", :id => 1).should == "/businesses/1"
    end
  
    it "should map { :controller => 'businesses', :action => 'destroy', :id => 1} to /businesses/1" do
      route_for(:controller => "businesses", :action => "destroy", :id => 1).should == "/businesses/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'businesses', action => 'index' } from GET /businesses" do
      params_from(:get, "/businesses").should == {:controller => "businesses", :action => "index"}
    end
  
    it "should generate params { :controller => 'businesses', action => 'new' } from GET /businesses/new" do
      params_from(:get, "/businesses/new").should == {:controller => "businesses", :action => "new"}
    end
  
    it "should generate params { :controller => 'businesses', action => 'create' } from POST /businesses" do
      params_from(:post, "/businesses").should == {:controller => "businesses", :action => "create"}
    end
  
    it "should generate params { :controller => 'businesses', action => 'show', id => '1' } from GET /businesses/1" do
      params_from(:get, "/businesses/1").should == {:controller => "businesses", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'businesses', action => 'edit', id => '1' } from GET /businesses/1;edit" do
      params_from(:get, "/businesses/1/edit").should == {:controller => "businesses", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'businesses', action => 'update', id => '1' } from PUT /businesses/1" do
      params_from(:put, "/businesses/1").should == {:controller => "businesses", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'businesses', action => 'destroy', id => '1' } from DELETE /businesses/1" do
      params_from(:delete, "/businesses/1").should == {:controller => "businesses", :action => "destroy", :id => "1"}
    end
  end
end