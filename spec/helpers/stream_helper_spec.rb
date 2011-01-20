require 'spec_helper'

describe StreamHelper do
  before do
    @user = alice
    @aspect = @user.aspects.first
    @post = @user.post(:status_message, :message => "hi", :to => @aspect.id)
  end
  it 'renders a new comment form' do
    new_comment_form(@post.id).should ==
      @controller.render_to_string(:partial => 'comments/new_comment', :locals => {:post_id => @post.id})
  end
  it 'renders it fast the second time' do
    new_comment_form(@post.id)
    time = Benchmark.realtime{
      new_comment_form(@post.id)
    }
    (time*1000).should < 1
  end
end
