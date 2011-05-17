#   Copyright (c) 2010, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

require 'spec_helper'

describe ContactsController do
  before do
    @aspect = alice.aspects.first
    @contact = alice.contact_for(bob.person)

    sign_in :user, alice
    @controller.stub(:current_user).and_return(alice)
  end

  describe '#new' do
    it 'assigns a person' do
      get :new, :person_id => bob.person.id
      assigns[:person].should == bob.person
    end

    it 'assigns aspects without person' do
      get :new, :person_id => bob.person.id
      assigns[:aspects_without_person].should =~ alice.aspects
    end
  end

  describe '#edit' do
    it 'assigns a contact' do
      get :edit, :id => @contact.id
      assigns[:contact].should == @contact
    end
    
    it 'assigns a person' do
      get :edit, :id => @contact.id
      assigns[:person].should == @contact.person
    end
  end

  describe '#destroy' do
    it 'disconnects from the person' do
      alice.should_receive(:disconnect).with(@contact)
      delete :destroy, :id => @contact.id
    end
    
    it 'flases success if the contact is not destroyed' do
      alice.stub!(:disconnect).and_return(true)
      delete :destroy, :id => @contact.id
      flash[:notice].should_not be_empty
    end

    it 'flases failure if the contact is not destroyed' do
      alice.stub!(:disconnect).and_return(false)
      delete :destroy, :id => @contact.id
      flash[:error].should_not be_empty
    end

    it 'redirects back to the person page' do
      delete :destroy, :id => @contact.id
      response.should redirect_to(@contact.person)
    end
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
end
