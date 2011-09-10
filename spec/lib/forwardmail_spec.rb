require 'forwardmail'

describe Morley do
  include Morley
  before do
    @forwardto = "alice"
  end

  describe '#checkifsystemalias' do
    before do
      @expected_answer = "ERROR: System reserved email sorry can not be added to forwarding rules"
      @user = "apache"
      @email = "bob@bob.com"
      @result = Morley::Forwardmailon::forward(@user,@email,1) 
    end

    it 'sends a system reserved username' do
      @result.should == @expected_answer
    end
  end

  describe '#newalias' do
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

end
