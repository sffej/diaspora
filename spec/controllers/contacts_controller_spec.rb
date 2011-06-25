#   Copyright (c) 2010, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

require 'spec_helper'

describe ContactsController do
  before do
    sign_in :user, alice
    @controller.stub(:current_user).and_return(alice)
  end

  describe '#sharing' do
    it "succeeds" do
      get :sharing
      response.should be_success
    end

    it 'eager loads the aspects' do
      get :sharing
      assigns[:contacts].first.aspect_memberships.loaded?.should be_true
    end

    it "assigns only the people sharing with you with 'share_with' flag" do
      get :sharing, :id => 'share_with'
      assigns[:contacts].to_set.should == alice.contacts.sharing.to_set
    end
  end

  describe '#index' do
    it "succeeds" do
      get :index
      response.should be_success
    end

    it "assigns aspect to manage" do
      get :index
      assigns(:aspect).should == :manage
    end

    it "assigns contacts" do
      get :index
      contacts = assigns(:contacts)
      contacts.to_set.should == alice.contacts.to_set
    end

    it "generates a jasmine fixture", :fixture => 'jasmine' do
      get :index
      save_fixture(html_for("body"), "aspects_manage")
    end
  end
end
