require 'rubygems'
require 'contest'
require 'ruby-debug'
require File.dirname(__FILE__) + "/../lib/bisect"

class TestBisect < Test::Unit::TestCase
  setup do
    @hash = { :a => 1, :b => 2, :c => { :d => 3 }, :foo => { :bar => { :baz => 'bang', :bing => 'boom', :bob => 'boo' }, :bad => 'beep' } }
  end
  
  context "with a single parameter" do
    should "keep a" do
      assert_equal 1, @hash.bisect(:a)[:a]
    end
    
    should "strip everything else" do
      assert_equal 1, @hash.bisect(:a).size
    end
  end
  
  context "with multiple parameters" do
    should "keep a" do
      assert_equal 1, @hash.bisect(:a, :b)[:a]
    end

    should "keep b" do
      assert_equal 2, @hash.bisect(:a, :b)[:b]
    end

    should "strip c" do
      assert !@hash.bisect(:a, :b)[:c]
    end
    
    should "strip everything else" do
      assert_equal 2, @hash.bisect(:a, :b).size
    end
  end
  
  context "when nested" do
    should "keep bar in first level" do
      assert @hash[:foo].bisect(:bar => :baz)[:bar]
    end
    
    should "strip bad in first level" do
      assert !@hash[:foo].bisect(:bar => :baz)[:bad]
    end
    
    should "keep baz under bar" do
      assert_equal 'bang', @hash[:foo].bisect(:bar => :baz)[:bar][:baz]
    end

    should "strip bing from under bar" do
      assert !@hash[:foo].bisect(:bar => :baz)[:bar][:bing]
    end

    context "with multiple nested keys" do
      should "keep baz under bar" do
        assert_equal 'bang', @hash[:foo].bisect(:bar => [ :baz, :bob ])[:bar][:baz]
      end

      should "keep bob under bar" do
        assert_equal 'boo', @hash[:foo].bisect(:bar => [ :baz, :bob ])[:bar][:bob]
      end
      
      should "strip bing from under bar" do
        assert !@hash[:foo].bisect(:bar => :baz)[:bar][:bing]
      end
    end
    
    context "when deeply nested" do
      should "keep baz under bar under foo" do
        assert_equal 'bang', @hash.bisect(:foo => { :bar => :baz })[:foo][:bar][:baz]
      end
      
      should "strip bad under foo" do
        assert !@hash.bisect(:foo => { :bar => :baz })[:foo][:bad]
      end
    end
  end
  
  should "be sure all our documentation examples really work" do
    assert_equal({ :a => 1 }, { :a => 1, :b => 2 }.bisect(:a))
    assert_equal({ :a => 1, :b => 2 }, { :a => 1, :b => 2, :c => 3 }.bisect(:a, :b))
    assert_equal({ :c => { :d => 3 } }, { :a => 1, :c => { :d => 3 } }.bisect(:c => :d))
    assert_equal({ :a => 1, :c => { :e => { :f => 4 } } }, { :a => 1, :b => 2, :c => { :d => 3, :e => { :f => 4 } } }.bisect(:a, { :c => { :e => :f } }))
    assert_equal({ :c => { :d => 3, :e => { :f => 4 } } }, { :a => 1, :b => 2, :c => { :d => 3, :e => { :f => 4 } } }.bisect({ :c => [ :d, :e ] }))
  end
end
