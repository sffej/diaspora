require 'spec_helper'
require 'forwardmail'

describe Morley do
  include Morley

  describe '#checkifsystemalias' do
    before do
      AppConfig.system_aliases = File.join(Rails.root, 'spec', 'fixtures', 'aliases')
      AppConfig.pod_aliases = File.join(Rails.root, 'spec', 'fixtures', 'daliases')
    end

    it 'sends a system reserved username' do
      @expected_answer = "ERROR: System reserved email sorry can not be added to forwarding rules"
      @user = "thundercat1"
      @email = "eye@ofthundara.com"
      @result = Morley::Forwardmailon::forward(@user,@email,1)
      @result.should == @expected_answer
    end

    it 'add a new forward' do
      @expected_answer = "Success: Added your forward"
      @user = "ohhhhhbilly"
      @email = "bob@bob.com"
      Morley::Forwardmailon::forward(@user,@email,0)
      @result = Morley::Forwardmailon::forward(@user,@email,1)
      @result.should == @expected_answer
    end

#    it 'update a forward' do
#      @expected_answer = "Success: Updated your existing forward"
#      @user = "ohhhhhbilly"
#      @email = "bob2@bob2.com"
#      @result = Morley::Forwardmailon::forward(@user,@email,1)
#      @result.should == @expected_answer
#    end

#    it 'alias file is read with new forward' do
#      @expected_answer = "Success: Removed your forward"
#      @user = "ohhhhhbilly"
#      @email = "bob2@bob2.com"
#      @result = File.open(AppConfig[:pod_aliases]).read
#      @result.should include @user+':'+@email
#    end

   it 'alias file is formated properly' do
      @result = AppConfig.pod_aliases
      @result.each_line { |line|
        line.should include ':'
      }
   end

#  end


#need to remove forward
#    it 'update a forward' do
#      @expected_answer = "Success: Removed your forward"
#     @user = "ohhhhhbilly"
#      @email = "bob2@bob2.com"
#      @result = Morley::Forwardmailon::forward(@user,@email,0)
#      @result.should == @expected_answer
#    end

#    it 'alias file is read with new forward' do
#      @expected_answer = "Success: Removed your forward"
#      @user = "ohhhhhbilly"
#      @email = "bob2@bob2.com"
#      @result = File.open(AppConfig[:pod_aliases]).read
#      @result.should_not include @user+':'+@email
#    end

   it 'alias file is formated properly' do
      @result = AppConfig.pod_aliases
      @result.each_line { |line|
        line.should include ':'
      }
   end
 end

end
