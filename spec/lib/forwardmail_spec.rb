require 'spec_helper'
require 'forwardmail'

describe Morley do
  include Morley
  before do
    @forwardto = "alice"
  end

  describe '#checkifsystemalias' do
    before do
      @expected_answer = "ERROR: System reserved email sorry can not be added to forwarding rules"
      @user = "thundercat1"
      @email = "eye@ofthundara.com"
      AppConfig[:system_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'aliases')
      AppConfig[:pod_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'daliases')
      @result = Morley::Forwardmailon::forward(@user,@email,1) 
    end

    it 'sends a system reserved username' do
      @result.should == @expected_answer
    end
  end

  describe '#create newalias' do
    before do
      @expected_answer = "Success: Added your forward"
      @user = "ohhhhhbilly"
      @email = "bob@bob.com"
      Morley::Forwardmailon::forward(@user,@email,0)
      @result = Morley::Forwardmailon::forward(@user,@email,1)
    end

    it 'add a new forward' do
      @result.should == @expected_answer
    end
  end

  describe '#updatealias' do
    before do
      @expected_answer = "Success: Updated your existing forward"
      @user = "ohhhhhbilly"
      @email = "bob2@bob2.com"
      @result = Morley::Forwardmailon::forward(@user,@email,1)
    end

    it 'update a forward' do
      @result.should == @expected_answer
    end
  end

#need to they verify the file is ready for posfix, sendmail with proper format

#need to remove forward

#need to then verify email forward is removed and ready for posfix processing


end
