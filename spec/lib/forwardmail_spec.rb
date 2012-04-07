#require 'spec_helper'
require 'forwardmail'

describe Morley do
  include Morley

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
      AppConfig[:system_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'aliases')
      AppConfig[:pod_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'daliases')
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
      AppConfig[:system_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'aliases')
      AppConfig[:pod_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'daliases')
      @result = Morley::Forwardmailon::forward(@user,@email,1)
    end

    it 'update a forward' do
      @result.should == @expected_answer
    end
  end

#need to they verify the file is ready for posfix, sendmail with proper format
  describe '#verifyaliasfile' do
    before do
      @expected_answer = "Success: Removed your forward"
      @user = "ohhhhhbilly"
      @email = "bob2@bob2.com"
      AppConfig[:system_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'aliases')
      AppConfig[:pod_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'daliases')
      @result = File.open(AppConfig[:pod_aliases]).read
    end

    it 'alias file is read with new forward' do
      @result.should include @user+':'+@email
    end

   it 'alias file is formated properly' do
      @result.each_line { |line|
        line.should include ':'
      }
   end

  end


#need to remove forward
  describe '#removealias' do
    before do
      @expected_answer = "Success: Removed your forward"
      @user = "ohhhhhbilly"
      @email = "bob2@bob2.com"
      AppConfig[:system_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'aliases')
      AppConfig[:pod_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'daliases')
      @result = Morley::Forwardmailon::forward(@user,@email,0)
    end

    it 'update a forward' do
      @result.should == @expected_answer
    end
  end

#need to then verify email forward is removed and ready for posfix processing
  describe '#verifyaliasfile' do
    before do
      @expected_answer = "Success: Removed your forward"
      @user = "ohhhhhbilly"
      @email = "bob2@bob2.com"
      AppConfig[:system_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'aliases')
      AppConfig[:pod_aliases] = File.join(Rails.root, 'spec', 'fixtures', 'daliases')
      @result = File.open(AppConfig[:pod_aliases]).read
    end

    it 'alias file is read with new forward' do
      @result.should_not include @user+':'+@email
    end

   it 'alias file is formated properly' do
      @result.each_line { |line|
        line.should include ':'
      }
   end
 end

end
